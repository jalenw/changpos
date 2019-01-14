//
//  ForgetViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2017/7/22.
//  Copyright © 2017年 intexh. All rights reserved.
//

#import "ForgetViewController.h"
#import "CountdownManager.h"

@interface ForgetViewController ()<CountdownManagerDelegate>
{
    int i;
}
@property(nonatomic,strong)CountdownManager * countDownManager;
@end

@implementation ForgetViewController

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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =RGB(46, 48, 58);
    self.phone.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.phone.placeholder attributes:@{NSForegroundColorAttributeName: RGB(196,196,196)}];
    self.code.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.code.placeholder attributes:@{NSForegroundColorAttributeName: RGB(196,196,196)}];
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.password.placeholder attributes:@{NSForegroundColorAttributeName: RGB(196,196,196)}];
    self.rePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.rePassword.placeholder attributes:@{NSForegroundColorAttributeName: RGB(196,196,196)}];
    [self setupForDismissKeyboard];
    self.title = @"忘记密码";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)getCodeAct:(UIButton *)sender {
    [[ServiceForUser manager]postMethodName:@"mobile/connect/get_sms_captcha" params:@{@"phone":self.phone.text,@"type":@"1"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            self.countDownManager.registTime = 60;
            [self.countDownManager timerStart];
        }
        else [AlertHelper showAlertWithTitle:error];
    }];
}

- (IBAction)confirmAct:(UIButton *)sender {
    if (![self.password.text isEqualToString:self.rePassword.text]) {
        [AlertHelper showAlertWithTitle:@"密码不一致"];
        return;
    }
    [self.view endEditing:YES];
    [[ServiceForUser manager]postMethodName:@"mobile/connect/find_password" params:@{@"phone":self.phone.text,@"password":self.password.text,@"re_password":self.rePassword.text,@"captcha":self.code.text,@"client":@"ios"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            [AlertHelper showAlertWithTitle:@"修改成功"];
        }
        else [AlertHelper showAlertWithTitle:error];
    }];
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.countDownManager.delegate = nil;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.countDownManager.delegate = self;
}
@end
