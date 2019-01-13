//
//  PaySetPWViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/8.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "PaySetPWViewController.h"
#import "CountdownManager.h"
#import "PWInputViewController.h"

@interface PaySetPWViewController ()<CountdownManagerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (weak, nonatomic) IBOutlet UITextField *codeTextFiled;
@property (strong, nonatomic) CountdownManager * countDownManager;
@property(nonatomic,strong)NSString *url;

@end

@implementation PaySetPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.phoneTF.text =AppDelegateInstance.defaultUser.member_mobile;
    self.view.backgroundColor =RGB(48, 46, 58);
}
-(void)setupNav
{
    UILabel *titleview = [[UILabel alloc]init];
    titleview.text = @"支付设置";
    titleview.textColor = RGB(253, 210, 88);
    titleview.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleview;
 }

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.countDownManager.delegate = self;
    
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.countDownManager timerStop];
    self.countDownManager.delegate = nil;
}

- (IBAction)nextVCAction:(UIButton *)sender {
    PWInputViewController *PWinputVC = [[PWInputViewController alloc]init];
    [self.navigationController pushViewController:PWinputVC animated:YES];
}


#pragma mark - 倒计时ManagerDelegate
- (void)changeUIWithSec {
    if (_countDownManager.payPwdTime != 0) {
        self.codeBtn.enabled = NO;
        [self.codeBtn setTitle:[NSString stringWithFormat:NSLocalizedString(@"%@秒后重试", nil), [NSNumber numberWithInteger:_countDownManager.payPwdTime]] forState:UIControlStateDisabled];
        [self.codeBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateDisabled];
        [self.codeBtn setBackgroundColor:[UIColor lightGrayColor]];
    }
    else {
        self.codeBtn.enabled = YES;
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

- (IBAction)getCAPTCHA:(UIButton *)sender {
    
    WEAKSELF
    [SVProgressHUD show];
   if ([_phoneTF.text isEqualToString:@""] ) {
        [AlertHelper showAlertWithTitle:@"手机号不能为空"];
        return;
    }
    if (![Tooles valiMobile:_phoneTF.text]) {
         [AlertHelper showAlertWithTitle:@"请输入正确的手机号"];
        return;
    }
    
    [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"phone":_phoneTF.text,
                               @"type":@(7),
                               @"client":@"ios",
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/connect/get_sms_captcha" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            if ([data safeIntForKey:@"code"]==200) {
                 weakSelf.countDownManager.payPwdTime = 60;
                 [weakSelf.countDownManager timerStart];
           
            }else{//开发输出错误
                  NSLog(@"手机验证错误---%@",requestFailed);
            }
        }else{
             [AlertHelper showAlertWithTitle:error];
        }
        
    }];
}

- (IBAction)goToPaySetVCAction:(UIButton *)sender {
    if ([Tooles isEmpty:self.codeTextFiled.text]) {
        [AlertHelper showAlertWithTitle:@"验证码不能为空"];
    return;
    }
    
    [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"type":@(7),
                               @"captcha":self.codeTextFiled.text,
                               @"phone":self.phoneTF.text,
                               @"client":@"ios"
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/connect/check_sms_captcha" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            if ([data safeIntForKey:@"code"]==200) {
                PWInputViewController *PWinputVC = [[PWInputViewController alloc]init];
                PWinputVC.navigationItem.title = @"完善资料";
                //1---我的页面---设置修改新密码
                PWinputVC.Incometype =@"1";
                PWinputVC.codeStr = self.codeTextFiled.text;
                PWinputVC.tipsLabelStr =@"设置支付密码，以添加银行卡";
                [self.navigationController pushViewController:PWinputVC animated:YES];
            }else{
               NSLog(@"设置验证码错误------%@",requestFailed);
            }
        } else{
               [AlertHelper showAlertWithTitle:error];
        }
    }];
}

@end
