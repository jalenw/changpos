//
//  LoginViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2017/7/22.
//  Copyright © 2017年 intexh. All rights reserved.
//

#import "LoginViewController.h"
#import "RegViewController.h"
#import "CodeLoginViewController.h"
#import "SelectRegistViewController.h"
#import "ForgetViewController.h"
#import <ShareSDK/ShareSDK.h>
@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(48, 46, 58);
    [self setupForDismissKeyboard];
    self.phone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.phone.placeholder attributes:@{NSForegroundColorAttributeName: RGB(196,196,196)}];
    self.passWord.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.passWord.placeholder attributes:@{NSForegroundColorAttributeName: RGB(196,196,196)}];
    self.navigationController.navigationBarHidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(forgetPWAct)];
    [self.forgetPWImageview addGestureRecognizer:tap];
    UITapGestureRecognizer *regtap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(regImageviewAct)];
    [self.regImageview addGestureRecognizer:regtap];
    
}



-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)regImageviewAct{
    SelectRegistViewController *vc =[[SelectRegistViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}


- (IBAction)codeAction:(UIButton *)sender {
    self.passWord.secureTextEntry =!self.passWord.secureTextEntry;
}


- (void)forgetPWAct{
    ForgetViewController *vc = [[ForgetViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)loginAct:(UIButton *)sender {
    [self.view endEditing:YES];
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/login/index" params:@{@"username":self.phone.text,@"password":self.passWord.text} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [HTTPClientInstance saveToken:[[data safeDictionaryForKey:@"result"] safeStringForKey:@"key"] uid:[[data safeDictionaryForKey:@"result"] safeStringForKey:@"userid"]];
            
            [[ServiceForUser manager]postMethodName:@"mobile/member/get_member_info" params:nil block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
                if (status) {
                    AppDelegateInstance.defaultUser = [User insertOrReplaceWithDictionary:[data safeDictionaryForKey:@"result"] context:AppDelegateInstance.managedObjectContext];
                    [AppDelegateInstance showMainPage];
                }
            }];
            
//            AppDelegateInstance.defaultUser = [User insertOrReplaceWithDictionary:[data safeDictionaryForKey:@"datas"] context:AppDelegateInstance.managedObjectContext];
//            [AppDelegateInstance showMainPage];
        }
        else [AlertHelper showAlertWithTitle:error];
    }];
}

- (IBAction)backAct:(UIButton *)sender {
    [AppDelegateInstance showMainPage];
}

- (IBAction)thirdLogin:(UIButton *)sender {
    [self loginWithShareType:sender.tag];
}

- (void)loginWithShareType:(SSDKPlatformType)shareType{
    [ShareSDK cancelAuthorize:shareType];
    [ShareSDK getUserInfo:shareType onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
        if (state == SSDKResponseStateSuccess) {
            [self loginWithUserInfo:user];
        }else if (state == SSDKResponseStateFail || state == SSDKResponseStateCancel){
            
            if (shareType == SSDKPlatformSubTypeQZone) {
                [AlertHelper showAlertWithTitle:@"QQ登陆失败"];
            }else if (shareType == SSDKPlatformTypeWechat) {
                [AlertHelper showAlertWithTitle:@"微信登录失败"];
                
            }else if (shareType == SSDKPlatformTypeSinaWeibo){
                [AlertHelper showAlertWithTitle:@"微博登录失败"];
            }
        }
    }];
}


- (void)loginWithUserInfo:(SSDKUser*)userInfo{
    NSString *name = userInfo.nickname;
    SSDKCredential *credential = userInfo.credential;
    NSString* openId = [credential uid];
    NSString *icon = userInfo.icon;
    NSDictionary *param;
    NSString *url = @"";//第三方登录请求地址
    if (userInfo.platformType == SSDKPlatformSubTypeQZone) {
        param = @{@"headimgurl":icon,@"nick_name":name,@"openid":openId,@"client":@"IOS"};
        url = @"";//qq登录地址
    }else if (userInfo.platformType == SSDKPlatformTypeWechat){
        param = @{@"headimgurl":icon,@"nick_name":name,@"openid":openId,@"client":@"IOS",@"unionid":[userInfo.rawData safeStringForKey:@"unionid"]};
        url = @"";//wechat登录地址
    }else if (userInfo.platformType == SSDKPlatformTypeSinaWeibo){
        param = @{@"headimgurl":icon,@"nick_name":name,@"openid":openId,@"client":@"IOS"};
        url = @"";//weibo登录地址
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:url params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [SVProgressHUD show];
            [HTTPClientInstance saveToken:[[data safeDictionaryForKey:@"datas"] safeStringForKey:@"key"] uid:[[data safeDictionaryForKey:@"datas"] safeStringForKey:@"member_id"]];
            AppDelegateInstance.defaultUser = [User insertOrReplaceWithDictionary:[data safeDictionaryForKey:@"datas"] context:AppDelegateInstance.managedObjectContext];
            [AppDelegateInstance showMainPage];
        }
        else [AlertHelper showAlertWithTitle:error];
    }];
}


@end
