//
//  ConnectQrCodeViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/31.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ConnectQrCodeViewController.h"

@interface ConnectQrCodeViewController ()

@end

@implementation ConnectQrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"钱客通商户入网";
    [[ServiceForUser manager]postMethodName:@"mobile/index/get_platbg_list" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            self.name.text = [[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"qrimg"]safeStringForKey:@"adv_title"];
            [self.qrImg sd_setImageWithURL:[NSURL URLWithString:[[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"qrimg"]safeStringForKey:@"adv_code"]]];
            [self.bgImg sd_setImageWithURL:[NSURL URLWithString:[[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"bgimg"]safeStringForKey:@"adv_code"]]];
        }
    }];
}
@end
