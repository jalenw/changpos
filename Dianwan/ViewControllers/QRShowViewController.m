//
//  QRShowViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/6.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "QRShowViewController.h"

@interface QRShowViewController ()

@end

@implementation QRShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的二维码";
    [[ServiceForUser manager]postMethodName:@"mobile/memberinviter/index" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            self.name.text = [[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"member_name"];
            self.code.text = [[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"inviter_code"];
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:[[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"member_avatar"]]];
            [self.img sd_setImageWithURL:[NSURL URLWithString:[[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"qrcode_url"]]];
            [self.bgImg sd_setImageWithURL:[NSURL URLWithString:[[[data safeDictionaryForKey:@"result"]safeArrayForKey:@"img_bg_list"][0] safeStringForKey:@"adv_code"]]];
            
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
