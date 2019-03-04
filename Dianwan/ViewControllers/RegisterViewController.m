//
//  RegisterViewController.m
//  ZJDecoration
//
//  Created by ZNH on 2018/4/10.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "RegisterViewController.h"
#import "RegisterViewModel.h"
#import "ZTNavigationController.h"
#import "CountdownManager.h"
#import "IQKeyboardManager.h"
#import "LoginViewController.h"

@interface RegisterViewController ()<CountdownManagerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) CountdownManager * countDownManager;
@property (strong, nonatomic) RegisterViewModel *registerViewModel;

@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *xieyiImageView;

@property (weak, nonatomic) IBOutlet UITextField *passwordTF;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UITextField *codeTF;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTF;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UITextField *pwTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *pwTextFileds;


@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UIButton *agreementBtn;

@end

@implementation RegisterViewController


-(instancetype)initWithCode:(NSString *)string{
    self=[super init];
    if (self) {
        self.emailTF.text = string;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.countDownManager.delegate = self;
   
        [IQKeyboardManager sharedManager].enable = YES;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.phoneTF.delegate =self;
    self.phoneTF.tag =1;
    self.codeTF.delegate =self;
    self.codeTF.tag =2;
    self.passwordTF.delegate =self;
    self.passwordTF.tag =3;
    self.confirmPasswordTF.delegate =self;
    self.confirmPasswordTF.tag=3;
    self.pwTextFiled.delegate =self;
    self.pwTextFileds.tag =2;
    self.pwTextFileds.delegate =self;
    self.pwTextFiled.tag=2;
    UITapGestureRecognizer *xieyitap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAgreeAct)];
    [self.xieyiImageView addGestureRecognizer:xieyitap];
    
    
    self.view.backgroundColor = RGB(48, 46, 58);
}

//限制输入
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    
    {
        if(textField.tag == 1){
            if (range.length + range.location > textField.text.length) {
                return NO;
               }
             NSUInteger length = textField.text.length + string.length - range.length;
             return length <= 11;
        }else if(textField.tag == 2){
            if (range.length + range.location > textField.text.length) {
                return NO;
                }
            NSUInteger length = textField.text.length + string.length - range.length;
            return length <= 6;
        }
            else {
                if (range.length + range.location > textField.text.length) {
                    return NO;
                }
                NSUInteger length = textField.text.length + string.length - range.length;
                return length <= 16;
        }
           
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 按钮点击

- (IBAction)clickGetCodeBtn:(UIButton *)sender {
    WEAKSELF
    [self.registerViewModel requestCAPTCHAByAccount:_phoneTF.text Success:^(NSInteger time) {
        [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
        weakSelf.countDownManager.registTime = time;
        [weakSelf.countDownManager timerStart];
    } Failure:^(NSString *msg) {
        [AlertHelper showAlertWithTitle:msg];
    }];
}
- (IBAction)clickRegisterBtn:(UIButton *)sender {

    if (!self.agreementBtn.isSelected) {
       [SVProgressHUD showImage:nil status:@"请阅读并同意《用户注册协议》"];
        return;
    }
    if([Tooles isEmpty:self.codeTF.text]){
        [SVProgressHUD showImage:nil status:@"验证码不能为空"];
        return;
    }
    if([Tooles isEmpty:self.passwordTF.text]){
        [SVProgressHUD showImage:nil status:@"请输入登录密码"];
        return;
    }
    
    if(![self.confirmPasswordTF.text isEqualToString:self.passwordTF.text]){
        [SVProgressHUD showImage:nil status:@"两次输入的登录密码不一致，请确认后再试"];
        return;
    }
    if([Tooles isEmpty:self.confirmPasswordTF.text]){
        [SVProgressHUD showImage:nil status:@"确认密码不能为空"];
        return;
    }
    if([Tooles isEmpty:self.pwTextFiled.text]){
        [SVProgressHUD showImage:nil status:@"请输入支付密码"];
        return;
    }
    if (![Tooles checkTextMin:6 Max:16 Text:self.passwordTF.text]) {
        [SVProgressHUD showImage:nil status:@"请设置6-16位的字母或数字密码"];
        return;
    }
    if([Tooles isEmpty:self.pwTextFileds.text]){
        [SVProgressHUD showImage:nil status:@"确认支付密码不能为空"];
        return;
    }
    if(![self.confirmPasswordTF.text isEqualToString:self.passwordTF.text]){
        [SVProgressHUD showImage:nil status:@"两次输入的登录密码不一致，请确认后再试"];
        return;
    }
    
    
    HIDE_KEY_BOARD
    [SVProgressHUD show];
    WEAKSELF
    [self.registerViewModel registerWithAccount:_phoneTF.text
                                       Password:_passwordTF.text
                                ConfirmPassword:_confirmPasswordTF.text
                                        CAPTCHA:_codeTF.text
                                          invitation:_emailTF.text
                                    pwTextFiled:self.pwTextFiled.text
                                   pwTextFileds:self.pwTextFileds.text
                                        Success:^(NSString *phone, NSString *password) {
                                            [AlertHelper showAlertWithTitle:@"注册成功"];

                                            AppDelegateInstance.window.rootViewController = [[ZTNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
                                        } Failure:^(NSString *msg) {
                                            [AlertHelper showAlertWithTitle:msg];

                                        }];
}

- (void)clickAgreeAct{
    
    CommonUIWebViewController *web = [[CommonUIWebViewController alloc]init];
    web.address = @"http://www.gdzuanqian.net/dist/index.html#/Agreement";
    [self.navigationController pushViewController:web animated:YES];    
    
}
- (IBAction)selectAgreement:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}


#pragma mark - 倒计时ManagerDelegate
- (void)changeUIWithSec {
    if (_countDownManager.registTime != 0) {
        self.codeBtn.enabled = NO;
        [self.codeBtn setTitle:[NSString stringWithFormat:NSLocalizedString(@"%@秒后重试", nil), [NSNumber numberWithInteger:_countDownManager.registTime]] forState:UIControlStateDisabled];
        [self.codeBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:193.0/255.0 blue:0 alpha:1] forState:UIControlStateDisabled];
        [self.codeBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    else {
        self.codeBtn.enabled = YES;
        [self.codeBtn setTitleColor:[UIColor colorWithRed:255.0/255.0 green:193.0/255.0 blue:0 alpha:1] forState:UIControlStateNormal];
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

- (RegisterViewModel *)registerViewModel {
    if (!_registerViewModel) {
        _registerViewModel = [[RegisterViewModel alloc] init];
    }
    return _registerViewModel;
}
@end
