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
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self.navigationController.navigationBar setBackgroundImage:[Tooles createImageWithColor:RGB(48, 46, 58)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
  
        [IQKeyboardManager sharedManager].enable = YES;
        [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
      [IQKeyboardManager sharedManager].enable = YES;
//    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
//    [self.navigationController.navigationBar setBackgroundImage:[Tooles createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"注册";
    self.phoneTF.delegate =self;
    self.phoneTF.tag =1;
    self.codeTF.delegate =self;
    self.codeTF.tag =2;
    self.pwTextFileds.delegate =self;
    self.pwTextFiled.tag =2;
    self.pwTextFiled.delegate =self;
    self.pwTextFileds.tag =2;
    

    
    self.view.backgroundColor = RGB(48, 46, 58);
}




    
    - (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
    
    {
        if(textField.tag == 1){
            if (range.length + range.location > textField.text.length) {
                return NO;
               }
             NSUInteger length = textField.text.length + string.length - range.length;
             return length <= 11;
        }else{
            if (range.length + range.location > textField.text.length) {
                return NO;
                }
            NSUInteger length = textField.text.length + string.length - range.length;
            return length <= 6;
        }
           
    }
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 按钮点击

- (IBAction)clickGetCodeBtn:(UIButton *)sender {
//    if(self.phoneTF.text.length!=11){
//        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请输入正确手机号"];
//        return;
//    }
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

//                                            if (self.resgiterSuccess){
//                                                self.resgiterSuccess(phone,password);
//                                            }
//                                            [weakSelf.navigationController popViewControllerAnimated:YES];
                                            
                                            AppDelegateInstance.window.rootViewController = [[ZTNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
                                        } Failure:^(NSString *msg) {
                                            [AlertHelper showAlertWithTitle:msg];

                                        }];
}

- (IBAction)clickAgreemt:(UIButton *)sender {
    
    CommonUIWebViewController *web = [[CommonUIWebViewController alloc]init];
    web.address = @"http://www.gdzuanqian.net/dist/index.html#/Agreement";
    [self.navigationController pushViewController:web animated:YES];
//    [WebManager gotoWebByUrl:[NSString stringWithFormat:@"http://www.gdzuanqian.net/dist/index.html#/Agreement"]
//                       Title:@""
//         LastTimeIsHiddenNav:NO
//                          VC:self];
    
    
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
