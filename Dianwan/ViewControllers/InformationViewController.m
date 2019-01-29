//
//  InformationViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/6.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "InformationViewController.h"

@interface InformationViewController ()

@end

@implementation InformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯";
    [[ServiceForUser manager]postMethodName:@"mobile/index/get_inforbg_list" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            NSString *bgUrl = [[data safeDictionaryForKey:@"result"] safeStringForKey:@"adv_code"];
            [self.img sd_setImageWithURL:[NSURL URLWithString:bgUrl]];
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
