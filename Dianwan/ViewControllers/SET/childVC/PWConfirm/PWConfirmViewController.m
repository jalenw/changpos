//
//  PWConfirmViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/9.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "PWConfirmViewController.h"
#import "UIView+EasyLayout.h"
#import "SYPasswordView.h"
@interface PWConfirmViewController ()
@property (weak, nonatomic) IBOutlet UILabel *StringLabel;
@property (nonatomic, strong) SYPasswordView *pasView;
@property (nonatomic, strong) UIButton  *nextbtn;

@end

@implementation PWConfirmViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"完善资料";
    self.view.backgroundColor =RGB(48, 46, 58);
    
    self.pasView = [[SYPasswordView alloc] initWithFrame:CGRectMake(30, 20, self.view.frame.size.width - 60, 45)];
    [self.view addSubview:_pasView];
    
    self.pasView.el_topToBottom(_StringLabel,20).el_rightToSuperView(30).el_leftToSuperView(30).el_toHeight(45);
    
    _nextbtn = [[UIButton alloc]init];
    [self.view addSubview:_nextbtn];
    [_nextbtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.nextbtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextbtn setBackgroundColor:[UIColor colorWithRed:245/255.0 green:183/255.0 blue:56/255.0 alpha:1]];
    _nextbtn.el_topToBottom(self.pasView,65).el_axisXToAxisX(self.pasView,0).el_toHeight(50).el_toWidth(150);
    [_nextbtn addTarget:self action:@selector(selectedmethon:) forControlEvents:UIControlEventTouchUpInside];
    //自动弹出数字键盘
    [self.pasView.textField becomeFirstResponder];
    self.pasView.textField.autocapitalizationType = UIKeyboardTypeNumberPad;
    
}


-(void)selectedmethon:(UIButton *)selectedmethon{
    if ([self.pasView.textField.text isEqualToString:self.passwordNum]) {
        NSDictionary * params =  @{
                                   @"paypwd":self.passwordNum,
                                   @"captcha": self.codeNum,
                              @"phone":AppDelegateInstance.defaultUser.member_mobile,
                                   @"client":@"ios"
                                   };
        [[ServiceForUser manager]postMethodName:@"mobile/member/update_paypwd" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            //检查1
            if (status) {
                if ([data safeIntForKey:@"code"]==200) {
                      [AlertHelper showAlertWithTitle:@"设置成功"];
                      [self.navigationController popToRootViewControllerAnimated:YES];
                }else{
                    NSLog(@"修改密码失败---%@",error);
                }
            }else{
                 [AlertHelper showAlertWithTitle:error];
            }
        }];
  
    }else{
        [AlertHelper showAlertWithTitle:@"两次输入的密码不一致"];
    }
    
}


@end
