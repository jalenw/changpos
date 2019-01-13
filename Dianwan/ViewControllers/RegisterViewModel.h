//
//  RegisterViewModel.h
//  YiShiDe
//
//  Created by ZNH on 2018/4/27.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RegisterViewModel : NSObject

//- (void)registerWithAccount:(NSString *)account
//                   Password:(NSString *)pwd
//            ConfirmPassword:(NSString *)confirmPwd
//                    CAPTCHA:(NSString *)captcha
//                      invitation:(NSString *)invitation
//                    Success:(void(^)(NSString *phone,NSString *password))registerSuccess
//                    Failure:(void(^)(NSString *msg))registerFailure;

- (void)registerWithAccount:(NSString *)account
                    Password:(NSString *)pwd
                    ConfirmPassword:(NSString *)confirmPwd
                    CAPTCHA:(NSString *)captcha
                    invitation:(NSString *)invitation
                    pwTextFiled:(NSString *)pwTextFiled
                    pwTextFileds:(NSString *)pwTextFileds
                    Success:(void(^)(NSString *userName,NSString *password))registerSuccess
                    Failure:(void(^)(NSString *msg))registerFailure ;

- (void)requestCAPTCHAByAccount:(NSString *)account
               Success:(void(^)(NSInteger time))suc
               Failure:(void(^)(NSString *msg))fal;
@end
