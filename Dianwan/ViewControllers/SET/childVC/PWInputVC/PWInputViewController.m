//
//  PWInputViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/8.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "PWInputViewController.h"
#import "PWConfirmViewController.h"
#import "UIView+EasyLayout.h"//布局使用
#import "SYPasswordView.h"
@interface PWInputViewController ()
@property (weak, nonatomic) IBOutlet UILabel *StringLabel;
@property (nonatomic, strong) SYPasswordView *pasView;
@property (nonatomic, strong) UIButton  *nextbtn;

@end

@implementation PWInputViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNav];
    self.view.backgroundColor =RGB(48, 46, 58);
    self.StringLabel.text =self.tipsLabelStr;
    //创建密码输入控价
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
    [self.pasView.textField becomeFirstResponder];
    self.pasView.textField.autocapitalizationType = UIKeyboardTypeNumberPad;
    
}

-(void)setupNav
{
    UILabel *titleview = [[UILabel alloc]init];
    titleview.text = @"完善资料";
    titleview.textColor = RGB(253, 210, 88);
    titleview.backgroundColor = [UIColor clearColor];
    self.navigationItem.titleView = titleview;
}

    
-(void)selectedmethon:(UIButton *)selectedmethon{
    if ([self.Incometype isEqualToString:@"1"]) {
        //再次确认密码，共输入密码---2次
            NSString *pwString =  self.pasView.textField.text;
            [self.pasView clearUpPassword];//zyf 改
            PWConfirmViewController *ConfirmPW = [[PWConfirmViewController alloc]init];
            ConfirmPW.passwordNum =pwString;
            ConfirmPW.codeNum =self.codeStr;
            [self.navigationController pushViewController:ConfirmPW animated:YES];
        
            //把输当前控制器从视图栈删除，避免f确认密码返回到第一次输入密码
            NSMutableArray *tempMarray = [NSMutableArray arrayWithArray:self.navigationController.viewControllers];
            [tempMarray removeObject:self];
            [self.navigationController setViewControllers:tempMarray animated:YES];
            [self removeFromParentViewController];
        };
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end