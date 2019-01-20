//
//  ChangeLoginPWViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/8.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "ChangeLoginPWViewController.h"
#import "CountdownManager.h"

@interface ChangeLoginPWViewController ()<CountdownManagerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) CountdownManager * countDownManager;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPWTF;
@property (weak, nonatomic) IBOutlet UIButton *securityBtn;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *changePwdBtn;
@end

@implementation ChangeLoginPWViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[Tooles createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];;
    
    self.countDownManager.delegate = self;
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setBackgroundImage:[Tooles createImageWithColor:RGB(48, 46, 58)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改登录密码";
    self.phoneTF.text =AppDelegateInstance.defaultUser.member_mobile;    
    self.passwordTF.delegate =self;
    self.passwordTF.tag =3;
    self.confirmPWTF.delegate =self;
    self.confirmPWTF.tag =3;
    self.codeTF.tag =2;
    self.codeTF.delegate =self;
}



- (IBAction)securityTextAction:(UIButton *)sender {
        self.passwordTF.secureTextEntry =!self.passwordTF.secureTextEntry;
        self.confirmPWTF.secureTextEntry = self.passwordTF.secureTextEntry;
}


#pragma mark - 倒计时ManagerDelegate
- (void)changeUIWithSec {
    if (_countDownManager.forgetTime != 0) {
        self.codeBtn.enabled = NO;
        [self.codeBtn setTitle:[NSString stringWithFormat:NSLocalizedString(@"%@秒后重试", nil), [NSNumber numberWithInteger:_countDownManager.forgetTime]] forState:UIControlStateDisabled];
        [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self.codeBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    else {
        self.codeBtn.enabled = YES;
        [self.codeBtn setTitleColor:[UIColor yellowColor] forState:UIControlStateNormal];
        [self.codeBtn setBackgroundColor:[UIColor whiteColor]];
    }
}


#pragma mark - 懒加载
- (CountdownManager *)countDownManager {
    if (!_countDownManager) {
        _countDownManager = [CountdownManager shareManager];
    }
    return _countDownManager;
}


#pragma mark - 按钮点击
- (IBAction)clickCodeBtn:(UIButton *)sender {
    WEAKSELF
    [SVProgressHUD show];
    
    [self requestCAPTCHAByAccount:_phoneTF.text
                                    Success:^(NSInteger time) {
                                        [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
                                        weakSelf.countDownManager.forgetTime = time;
                                        [weakSelf.countDownManager timerStart];
                                    } Failure:^(NSString *msg) {
                                          [AlertHelper showAlertWithTitle:msg];
                                    }];
    
}




- (IBAction)clickSubmitBtn:(UIButton *)sender {
    WEAKSELF
    [SVProgressHUD show];
    [self changePwdWithAccount:_phoneTF.text
                                         Password:_passwordTF.text
                                  ConfirmPassword:_confirmPWTF.text
                                          CAPTCHA:_codeTF.text
                                          Success:^{
                                            
                                              [weakSelf.navigationController popViewControllerAnimated:YES];
                                          } Failure:^(NSString *msg) {
                                              [AlertHelper showAlertWithTitle:msg];
                                          }];

    
    
}



- (void)changePwdWithAccount:(NSString *)account
                    Password:(NSString *)pwd
             ConfirmPassword:(NSString *)confirmPwd
                     CAPTCHA:(NSString *)captcha
                     Success:(void(^)(void))suc
                     Failure:(void(^)(NSString *msg))fal {
    if ([account isEqualToString:@""] ) {
        fal(@"手机号不能为空");
        return;
    }
//    //账号，账号规则由后台判断
    if (![Tooles valiMobile:account]) {
        fal(@"请输入正确的手机号");
        return;
    }
    if ([captcha isEqualToString:@""]) {
        fal(@"验证码不能为空");
        return;
    }
    if ([pwd isEqualToString:@""] ) {
        fal(@"密码不能为空");
        return;
    }
    if ([Tooles checkTextMin:6 Max:16 Text:pwd]) {
        fal(@"请输入6-16位字母、数字或符号组成的密码");
        return;
    }
    if (![pwd isEqualToString:confirmPwd]) {
        fal(@"密码与确认密码不一致");
        return;
    }
        
        
        NSDictionary * params =  @{
                                   @"phone":account,
                                   @"captcha":captcha,
                                   @"password":pwd,
                                   @"re_password":confirmPwd,
                                   @"client":@"ios"
                                   };
        [[ServiceForUser manager]postMethodName:@"mobile/connect/find_password" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
           
            NSLog(@"data = %@",data);
            NSLog(@"requestFailed=%@",requestFailed);
            NSLog(@"error=%@",error);
            [SVProgressHUD dismiss];
            if (status) {
                    [AlertHelper showAlertWithTitle:[data safeStringForKey:@"result"]];
                         suc();
            }else{
                [AlertHelper showAlertWithTitle:[NSString stringWithFormat:@"%@",error]];
            }
            
        }];

}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.tag ==4) {
        return NO;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if(textField.tag == 3){
        if (range.length + range.location > textField.text.length) {
             return NO;
            }
        NSUInteger length = textField.text.length + string.length - range.length;
          return length <= 16;
        return NO;
    }
    else{
        if (range.length + range.location > textField.text.length) {
            return NO;
            }
        NSUInteger length = textField.text.length + string.length - range.length;
        return length <= 6;
    }
    
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
                               @"type":@(3),
                               @"client":@"ios",
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/connect/get_sms_captcha" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
                suc(60);
        }else
            [AlertHelper showAlertWithTitle:error];
        
    }];

}


@end
