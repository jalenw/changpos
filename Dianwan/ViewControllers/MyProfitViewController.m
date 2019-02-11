//
//  MyProfitViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MyProfitViewController.h"
#import "TotalProfitViewController.h"
#import "PersonProfitViewController.h"
#import "TeamProfitViewController.h"
#import "MyProfitDetailViewController.h"
#import "CardBindViewController.h"
#import "BlockUIAlertView.h"
#import "WalletwithdrawalViewController.h"
#define marginTop 100
@interface MyProfitViewController ()
{
    NSDictionary *dict;
}
@end

@implementation MyProfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的收益";
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBarButtonWithTitle:@"收益明细"];
    [self getData];
}

-(void)getData
{
    [[ServiceForUser manager]postMethodName:@"mobile/recharge/my_earnings" params:@{@"type":@"1",@"date_type":@"day"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            dict = [data safeDictionaryForKey:@"result"];
            self.totalLb.text = [NSString stringWithFormat:@"￥%@",[[dict safeDictionaryForKey:@"price"] safeStringForKey:@"available"]];
            self.freezeLb.text = [NSString stringWithFormat:@"￥%@",[[dict safeDictionaryForKey:@"price"] safeStringForKey:@"freeze"]];
        }
        else
        {
            BlockUIAlertView *alertView = [[BlockUIAlertView alloc]initWithTitle:error message:nil cancelButtonTitle:@"取消" clickButton:^(NSInteger i) {
                if (i==0) {
                    [self.navigationController popViewControllerAnimated:YES];
                }
                else
                {
                    CardBindViewController *vc = [[CardBindViewController alloc]init];
                    vc.typetag=100;////100为普通跳转 zyf
                    [self.navigationController pushViewController:vc animated:YES];
                }
              
            } otherButtonTitles:@"确定"];
            [alertView show];
        }
    }];
}

-(void)rightbarButtonDidTap:(UIButton *)button
{
    MyProfitDetailViewController *vc = [[MyProfitDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray<NSString *> *)buttonTitleArray{
    return @[@"总收益",@"个人收益",@"团队收益"];
}

-(UIColor *)BtnbackgroundColor{
    return RGB(48, 46, 58);
}

- (BOOL)isAllowScroll{
    return NO;
}
-(UIColor *)normalTabTextColor{
    return [UIColor whiteColor];
}

-(UIColor *)selectTabTextColor{
    return RGB(241, 228, 142);
}


-(UIColor *)indicatorColor{
    return  RGB(251, 185, 55);}

-(CGFloat)indicatorWidth{
    return 80;
}

- (CGFloat)indicatorOffset{
    return (ScreenWidth/3-80)/3;
}

- (void)setupControllers{
    self.scrollView.top = marginTop;
    self.scrollView.height = ScreenHeight-marginTop-44;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    for (UIViewController *controller in self.controllerArray) {
        [controller.view removeFromSuperview];
        [controller removeFromParentViewController];
    }
    NSArray *titleArray = [self buttonTitleArray];
    NSMutableArray *controllerArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < titleArray.count; ++i) {
        UIViewController *controller = nil;
        if(i == 0){
            TotalProfitViewController *subController = [[TotalProfitViewController alloc] init];
            controller = subController;
            [self addChildViewController:controller];
            self.currentController = controller;
        }else if (i == 1){
            PersonProfitViewController *subController = [[PersonProfitViewController alloc] init];
            controller = subController;
            [self addChildViewController:controller];
        }else if (i == 2){
            TeamProfitViewController *subController = [[TeamProfitViewController alloc] init];
            controller = subController;
            [self addChildViewController:controller];
        }
        controller.view.height = self.scrollView.height;
        controller.view.width = ScreenWidth;
        controller.view.left = i*ScreenWidth;
        [self.scrollView addSubview:controller.view];
        [controllerArray addObject:controller];
    }
    self.controllerArray = [NSArray arrayWithArray:controllerArray];
    self.scrollView.contentSize = CGSizeMake(ScreenWidth*titleArray.count, 0);
    self.topHeaderView.top = 0;
    self.topHeaderView.backgroundColor = [UIColor clearColor];
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, marginTop, ScreenWidth, 44)];
    [headerView addSubview:self.topHeaderView];
    [self.view addSubview:headerView];
    self.topView.width = ScreenWidth;
    [self.view addSubview:self.topView];
}

- (CGFloat)topHeaderWidth{
    return ScreenWidth;
}

- (UIView*)createTopHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    return view;
}
- (IBAction)getMoneyAct:(UIButton *)sender {
    WalletwithdrawalViewController *walletwithdrawal = [[WalletwithdrawalViewController alloc]init];
    walletwithdrawal.price = self.totalLb.text;
    [self.navigationController pushViewController:walletwithdrawal animated:YES];
}
@end
