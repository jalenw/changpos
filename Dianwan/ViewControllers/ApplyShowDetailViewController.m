//
//  ApplyShowDetailViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/14.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "ApplyShowDetailViewController.h"

@interface ApplyShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *CompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *machineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *machineModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelLabel;
@property (weak, nonatomic) IBOutlet UIButton *agressBtn;
@property (weak, nonatomic) IBOutlet UIButton *disagressBtn;
@property (weak, nonatomic) IBOutlet UIView *feilvChanggeView;
@property (weak, nonatomic) IBOutlet UILabel *rateChangeLabel;

@end

@implementation ApplyShowDetailViewController

- (IBAction)dealApplyAction:(UIButton *)sender {
    
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/parentExamine" params:@{@"id":@(self.idNum),@"type":@(sender.tag)} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            [AlertHelper showAlertWithTitle:[data safeStringForKey:@"result"] duration:3];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [UIApplication sharedApplication].statusBarStyle =UIStatusBarStyleDefault;
    [self.navigationController.navigationBar setBackgroundImage:[Tooles createImageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];;
    
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    [self.navigationController.navigationBar setBackgroundImage:[Tooles createImageWithColor:RGB(48, 46, 58)] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title=@"申请详情";
    [self setupNav];
    self.view.backgroundColor = RGB(246, 246, 246);
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/examineAllocationDetail" params:@{@"id":@(self.idNum)} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            [self setupUI:result];
            
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    
    }];
}



-(void)setupNav{
    UILabel *titleview = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    titleview.text =@"申请详情";
    titleview.textAlignment = NSTextAlignmentCenter;
    [titleview setTextColor:[UIColor blackColor]];
    self.navigationItem.titleView =titleview;
    

    
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftSpace.width = -15;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(-15, 0, 44, 44)];
     [button setImage:[UIImage imageNamed:@"返回"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[leftSpace,rightBarItem];
    [self.navigationItem sx_setLeftBarButtonItem:rightBarItem];
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)setupUI:(NSDictionary *)dict{
    //判断是否出现审核按钮
    if ([dict safeIntForKey:@"is_type"]==1&&[[dict safeStringForKey:@"examine_type"] integerValue]==0 ) {
        self.agressBtn.hidden =NO;
        self.disagressBtn.hidden =NO;
    }
    self.titlelLabel.text =[dict safeStringForKey:@"title"];
    self.nameLabel.text =[dict safeStringForKey:@"member_name"];
    self.phoneNumLabel.text =[dict safeStringForKey:@"member_mobile"];
    self.CompanyLabel.text =[dict safeStringForKey:@"gc_name"];
    switch ([[dict safeStringForKey:@"examine_type"] integerValue]) {
        case 0:
            self.stateLabel.text = @"待上级审核 ";
            self.stateLabel.textColor = RGB(230, 185, 55);
            break;
        case 1:
            
            self.stateLabel.text = @"待平台审核 ";
            self.stateLabel.textColor = RGB(230, 185, 55);
            break;
        case 2:
            
            self.stateLabel.text = @"审核通过 ";
            self.stateLabel.textColor = RGB(230, 185, 55);
            break;
        case 3:
            
            self.stateLabel.text = @"审核失败 ";
              self.stateLabel.textColor = RGB(190, 0, 0);
            break;
            
    }
    self.machineNameLabel.text =[dict safeStringForKey:@"goods_name"];
    self.machineModeLabel.text =[dict safeStringForKey:@"goods_serial"];
    self.changeRateLabel.text =[dict safeStringForKey:@"decoration"];
  
}


@end
