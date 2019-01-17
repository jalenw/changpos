//
//  RegisterViewModel.m
//  YiShiDe
//
//  Created by ZNH on 2018/4/27.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "RegisterViewModel.h"

@implementation RegisterViewModel

- (void)registerWithAccount:(NSString *)account
                   Password:(NSString *)pwd
            ConfirmPassword:(NSString *)confirmPwd
                    CAPTCHA:(NSString *)captcha
                      invitation:(NSString *)invitation
                pwTextFiled:(NSString *)pwTextFiled
                pwTextFileds:(NSString *)pwTextFileds
                    Success:(void(^)(NSString *userName,NSString *password))registerSuccess
                    Failure:(void(^)(NSString *msg))registerFailure {
    if ([Tooles isEmpty:account] ) {
        registerFailure(@"手机号不能为空");
        return;
    }
    if (![Tooles valiMobile:account]) {
        registerFailure(@"请输入正确的手机号");
        return;
    }
    if ([Tooles isEmpty:captcha]) {
        registerFailure(@"验证码不能为空");
        return;
    }
    if ([Tooles isEmpty:invitation]) {
        registerFailure(@"推荐码不能为空");
        return;
    }
    
    if ([Tooles isEmpty:pwd] ) {
        registerFailure(@"密码不能为空");
        return;
    }

    if ([Tooles checkTextMin:6 Max:16 Text:pwd]) {
        registerFailure(@"请输入6-16位字母、数字或符号组成的密码");
        return;
    }
    
    if (![pwd isEqualToString:confirmPwd]) {
        registerFailure(@"密码与确认密码不一致");
        return;
    }
    
    
  
    
    if ([Tooles isEmpty:pwTextFiled] ) {
        registerFailure(@"支付密码不能为空");
        return;
    }
    if (pwTextFiled.length!=6) {
        registerFailure(@"请输入6位支付密码");
        return;
    }
    
    if (![pwTextFiled isEqualToString:pwTextFileds]) {
        registerFailure(@"支付密码与确认支付密码不一致");
        return;
    }
   
    
    [SVProgressHUD show];

    NSDictionary * params =  @{
                               @"phone":account,
                               @"captcha":captcha,
                               @"password":pwd,
                               @"re_password":confirmPwd,
                               @"client":@"ios",
                               @"paypwd":pwTextFiled,
                               @"re_paypwd":pwTextFileds,
                               @"inviter_id":invitation
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/connect/sms_register" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
            if (status) {
                registerSuccess(account,pwd);
            }else
                [AlertHelper showAlertWithTitle:error];
        
    }];

}

- (void)requestCAPTCHAByAccount:(NSString *)account
                        Success:(void(^)(NSInteger time))suc
                        Failure:(void(^)(NSString *msg))fal {
             
             if ([account isEqualToString:@""] ) {
                 fal(@"手机号不能为空");
                 return;
             }
             if (![Tooles valiMobile:account]) {
                 fal(@"请输入正确的手机号");
                 return;
             }
            [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"phone":account,
                               @"type":@(1),
                               @"client":@"ios",
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/connect/get_sms_captcha" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        
        if (status) {
                suc(60);
        }
        
        else [AlertHelper showAlertWithTitle:error];
        
    }];
}

@end
