//
//  RegViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2017/7/22.
//  Copyright © 2017年 intexh. All rights reserved.
//

#import "RegViewController.h"

@interface RegViewController ()

@end

@implementation RegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    self.title = @"注册";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doneAct:(UIButton *)sender {
    [self.view endEditing:YES];
    if (![self.passWord.text isEqualToString:self.rePassWord.text]) {
        [AlertHelper showAlertWithTitle:@"密码不一致"];
        return;
    }
    if (![self.payPassWord.text isEqualToString:self.rePayPassWord.text]) {
        [AlertHelper showAlertWithTitle:@"支付密码不一致"];
        return;
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/connect/sms_register" params:@{@"phone":self.phone.text,@"password":self.passWord.text,@"re_password":self.passWord.text,@"paypwd":self.payPassWord.text,@"re_paypwd":self.rePayPassWord.text,@"inviter_id":self.inviteCode.text,@"captcha":self.code.text} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [SVProgressHUD show];
            //注册成功后执行登录
            [[ServiceForUser manager]postMethodName:@"" params:@{@"member_mobile":self.phone.text,@"password":self.passWord.text,@"client":@"ios",@"login_end":@"2",@"doctor_examine":@"2"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
                [SVProgressHUD dismiss];
                if (status) {
                    [HTTPClientInstance saveToken:[[data safeDictionaryForKey:@"datas"] safeStringForKey:@"key"] uid:[[data safeDictionaryForKey:@"datas"] safeStringForKey:@"member_id"]];
                    AppDelegateInstance.defaultUser = [User insertOrReplaceWithDictionary:[data safeDictionaryForKey:@"datas"] context:AppDelegateInstance.managedObjectContext];
                    [AppDelegateInstance showMainPage];
                }
                else [AlertHelper showAlertWithTitle:error];
            }];
        }
        else [AlertHelper showAlertWithTitle:error];
    }];
}

- (IBAction)getCodeAct:(UIButton *)sender {
    [[ServiceForUser manager]postMethodName:@"mobile/connect/get_sms_captcha" params:@{@"phone":self.phone.text,@"type":@"1"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            sender.enabled = NO;
            __block int i = 60;
            NSTimer *codeTimer = [NSTimer timerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
                i--;
                sender.titleLabel.text = [NSString stringWithFormat:@"%d秒倒计时",i];
                [sender setTitle:[NSString stringWithFormat:@"%d秒倒计时",i] forState:UIControlStateNormal];
                if (i==0) {
                    [timer invalidate];
                    sender.enabled = YES;
                    [sender setTitle:@"发送验证码" forState:UIControlStateNormal];
                }
            }];
            [[NSRunLoop mainRunLoop] addTimer:codeTimer forMode:NSDefaultRunLoopMode];
        }
        else [AlertHelper showAlertWithTitle:error];
    }];
}
@end
