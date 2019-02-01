//
//  CardModifyViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/31.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "CardModifyViewController.h"

@interface CardModifyViewController ()

@end

@implementation CardModifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"结算卡修改";
    [self setupForDismissKeyboard];
}

- (IBAction)doneAct:(UIButton *)sender {
    if ([Tooles isEmpty:self.number.text]) {
        [AlertHelper showAlertWithTitle:self.number.placeholder];
        return;
    }
    if ([Tooles isEmpty:self.cardNumber.text]) {
        [AlertHelper showAlertWithTitle:self.cardNumber.placeholder];
        return;
    }
    if ([Tooles isEmpty:self.bankName.text]) {
        [AlertHelper showAlertWithTitle:self.bankName.placeholder];
        return;
    }
    if ([Tooles isEmpty:self.branchName.text]) {
        [AlertHelper showAlertWithTitle:self.branchName.placeholder];
        return;
    }
    if ([Tooles isEmpty:self.phone.text]) {
        [AlertHelper showAlertWithTitle:self.phone.placeholder];
        return;
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Statistics/balance_change" params:@{@"merchant_id":self.number.text,@"card_id":self.cardNumber.text,@"deposit_bank":self.bankName.text,@"bank_branch":self.branchName.text,@"phone_num":self.phone.text} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [AlertHelper showAlertWithTitle:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }
        else
            [AlertHelper showAlertWithTitle:error];
    }];
}
@end
