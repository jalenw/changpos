//
//  CheckDetailViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/1.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "CheckDetailViewController.h"

@interface CheckDetailViewController ()

@end

@implementation CheckDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"机具审核详情";
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/get_sn_transfer_detail" params:@{@"transfer_id":self.transfer_id} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            NSDictionary *dict = [data safeDictionaryForKey:@"result"];
            self.nameA.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"apply_member_name"]];
            self.nameB.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"member_name"]];
            self.phone.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"member_mobile"]];
            self.toolName.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"goods_name"]];
            self.snCode.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"sn_code"]];
            self.total.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"num"]];
            self.time.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"created_time_date"]];
            if ([dict safeIntForKey:@"state"]!=0) {
                self.bt1.hidden = YES;
                self.bt2.hidden = YES;
            }
            if ([dict safeIntForKey:@"state"]==1) {
                [self.tips setTitle:@"已同意" forState:UIControlStateNormal];
                self.tips.hidden = NO;
            }
            else if ([dict safeIntForKey:@"state"]==2) {
                [self.tips setTitle:@"已拒绝" forState:UIControlStateNormal];
                self.tips.hidden = NO;
            }
            else self.tips.hidden = YES;
        }
    }];
}

- (IBAction)checkAct:(UIButton *)sender {
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/edit_sn_transfer" params:@{@"transfer_id":self.transfer_id,@"state":@(sender.tag)} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [AlertHelper showAlertWithTitle:@"操作成功"];
        }
        else
            [AlertHelper showAlertWithTitle:error];
    }];
}
@end
