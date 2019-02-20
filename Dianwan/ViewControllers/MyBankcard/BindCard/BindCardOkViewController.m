//
//  BindCardOkViewController.m
//  BaseProject
//
//  Created by Mac on 2018/10/31.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "BindCardOkViewController.h"
#import "ToolManager.h"
#import "CountdownManager.h"
#import "CardBindViewController.h"
@interface BindCardOkViewController ()<CountdownManagerDelegate,UITextFieldDelegate>

@property (strong, nonatomic) CountdownManager * countDownManager;
@property (weak, nonatomic) IBOutlet UIView *bindSuccview;
@property (weak, nonatomic) IBOutlet UITextField *userNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardNumBer;
@property (weak, nonatomic) IBOutlet UITextField *IDLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneLabel;
@property (weak, nonatomic) IBOutlet UITextField *codeLabel;
@property (weak, nonatomic) IBOutlet UIButton *codeBtn;
@property (strong, nonatomic) IBOutlet UIView *BindSelectview;
@property (weak, nonatomic) IBOutlet UIView *cancleSelectview;
@property (weak, nonatomic) IBOutlet UIImageView *nextstepImageview;
@property (weak, nonatomic) IBOutlet UIImageView *cancleViewSureImageview;
@property (weak, nonatomic) IBOutlet UIImageView *cancleViewCancleImageview;
@property (weak, nonatomic) IBOutlet UIImageView *bindViewSureImageview;
@property (weak, nonatomic) IBOutlet UIImageView *bindViewCancleImageview;

@end
@implementation BindCardOkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定银行卡";
    [self addsubviews];
    self.view.backgroundColor = RGB(48, 46, 58);
    self.userNameLabel.text = AppDelegateInstance.defaultUser.member_name;
    self.IDLabel.text =  AppDelegateInstance.defaultUser.idcard;
    self.phoneLabel.delegate =self;
    self.phoneLabel.tag =2;
    self.codeLabel.delegate =self;
    self.codeLabel.tag=1;UITapGestureRecognizer *nexttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(backAction)];
    [self.nextstepImageview addGestureRecognizer:nexttap];
   
    UITapGestureRecognizer *cancleViewCancletap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleBindAction)];
    [self.cancleViewCancleImageview addGestureRecognizer:cancleViewCancletap];
    
    UITapGestureRecognizer *cancleViewSuretap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleViewSelectioncancleAction)];
    [self.cancleViewSureImageview addGestureRecognizer:cancleViewSuretap];
    
    UITapGestureRecognizer *bindViewSuretap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bindCardAction)];
    [self.bindViewCancleImageview addGestureRecognizer:bindViewSuretap];
    
    UITapGestureRecognizer *bindViewCancletap =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(bindSelectedCancledAction)];
    [self.bindViewSureImageview addGestureRecognizer:bindViewCancletap];
}

-(void)back
{
    for (UIViewController *temp in self.navigationController.viewControllers)
    {
        if ([temp isKindOfClass:[CardBindViewController class]]) {[self.navigationController popToViewController:temp animated:YES];}
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string

{
    if(textField.tag == 2){
        if (range.length + range.location > textField.text.length) {
            return NO;
        }
        NSUInteger length = textField.text.length + string.length - range.length;
        return length <= 11;
        return NO;
    }
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


-(void)addsubviews{
    self.BindSelectview.frame = [UIScreen mainScreen].bounds;//self.view.bounds;
    self.BindSelectview.hidden =YES;
    [self.view addSubview:self.BindSelectview];
    self.cancleSelectview.frame = [UIScreen mainScreen].bounds;//self.view.bounds;
    self.cancleSelectview.hidden =YES;
    [self.view addSubview:self.cancleSelectview];
    self.bindSuccview.frame =[UIScreen mainScreen].bounds;// self.view.bounds;
    self.bindSuccview.hidden =YES;
    [self.view addSubview:self.bindSuccview];
    
}

//放弃绑卡选择------放弃，继续绑卡
- (void)cancleBindAction{
    self.cancleSelectview.hidden =YES;
}

//放弃绑卡选择------彻底放弃
-(void)cancleViewSelectioncancleAction {
    self.BindSelectview.hidden=NO;
    self.cancleSelectview.hidden =YES;
}

//绑定选择-------放弃，放弃绑卡诗图现
- (void)bindSelectedCancledAction{
    self.BindSelectview.hidden=YES;
    self.cancleSelectview.hidden =NO;
}

- (IBAction)getCodeAction:(UIButton *)sender {
    if ([Tooles isEmpty:self.phoneLabel.text] ) {
        [AlertHelper showAlertWithTitle:@"手机号不能为空"];
        return;
    }
    if (![Tooles valiMobile:self.phoneLabel.text]) {
        
        [AlertHelper showAlertWithTitle:@"请输入正确的手机号"];
        return;
    }
    
    WEAKSELF
    [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"phone":_phoneLabel.text,
                               @"type":@(5),
                               @"client":@"ios",
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/connect/get_sms_captcha" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
                 weakSelf.countDownManager.registTime = 60;
                [weakSelf.countDownManager timerStart];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
        
    }];
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


- (void)backAction {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
      self.countDownManager.delegate = self;
    //禁用右滑返回
//    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.countDownManager.delegate = nil;
    //恢复右滑返回
//    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

//信息填完--绑卡选择view现
- (IBAction)bindSelectedAction:(id)sender {
    if([Tooles isEmpty:self.userNameLabel.text]){
        [AlertHelper showAlertWithTitle:@"姓名不能为空"];
        return ;
    }
    if([Tooles isEmpty:self.cardNumBer.text]){
        [AlertHelper showAlertWithTitle:@"银行卡号不能为空"];
        return ;
    }
    if([Tooles isEmpty:self.cardNumBer.text]){
        [AlertHelper showAlertWithTitle:@"请输入身份证号"];
        return ;
    }
//    if(![Tooles judgeIdentityStringValid:self.cardNumBer.text]){
//        [AlertHelper showAlertWithTitle:@"请输入正确的身份证号"];
//        return ;
//    }
    if([Tooles isEmpty:self.phoneLabel.text]){
        [AlertHelper showAlertWithTitle:@"请输入手机号"];
        return ;
    }
    if(![Tooles valiMobile:self.phoneLabel.text]){
        [AlertHelper showAlertWithTitle:@"请输入正确的手机号"];
        return ;
    }
    
    if([Tooles isEmpty:self.codeLabel.text]){
        [AlertHelper showAlertWithTitle:@"请输入验证码"];
        return ;
    }
    
    self.BindSelectview.hidden =NO;
}

//绑卡选择q-------确定按钮
- (void)bindCardAction {
    [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"client":@"ios",
                               @"user_name":self.userNameLabel.text,
                               @"idcard":self.IDLabel.text,
                               @"captcha":self.codeLabel.text,
                               @"phone":self.phoneLabel.text,
                               @"bank_card":self.cardNumBer.text
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/member_bank/bank_card_add" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            if ([data safeIntForKey:@"code"]==200) {
                //绑定成功
                self.BindSelectview.hidden =YES;
                self.bindSuccview.hidden =NO;
            }else{
                self.BindSelectview.hidden =YES;
//               [AlertHelper showAlertWithTitle:error];
                NSLog(@"绑定失败---%@",requestFailed);
            }
        }else{
            self.BindSelectview.hidden =YES;
           [AlertHelper showAlertWithTitle:error];
        }
        
    }];
}

@end
