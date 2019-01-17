//
//  messageCenterViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "messageCenterViewController.h"
#import "withdrawalViewController.h"
#import "SystemViewController.h"
#import "rewardViewController.h"

@interface messageCenterViewController ()

@end

@implementation messageCenterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"消息中心";
    // Do any additional setup after loading the view from its nib.
}

- (NSArray<NSString *> *)buttonTitleArray{
    return @[@"提现",@"奖励",@"系统"];
}

-(UIColor *)normalTabTextColor{
    return [UIColor blackColor];
}

-(UIColor *)selectTabTextColor{
     return [UIColor blackColor];
}


-(UIColor *)indicatorColor{
    return RGB(251, 185, 55);
}

-(CGFloat)indicatorWidth{
    return 70;
}

- (CGFloat)indicatorOffset{
    return ((ScreenWidth -32)/3-70)/2;
}

-(UIColor *)BtnbackgroundColor{
    return [UIColor whiteColor];
}

-(CGFloat)indicatorTop{
    return  self.topHeaderView.height +6;
}



- (void)setupControllers{
    self.scrollView.top = 0;
    self.scrollView.height = ScreenHeight-60;
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
            withdrawalViewController *subController = [[withdrawalViewController alloc] init];
            controller = subController;
            [self addChildViewController:controller];
            self.currentController = controller;
        }else if (i == 1){
            rewardViewController *subController = [[rewardViewController alloc] init];
            controller = subController;
            [self addChildViewController:controller];
        }else if (i == 2){
            SystemViewController *subController = [[SystemViewController alloc] init];
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
    self.topHeaderView.top = 8;
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 60)];
    topView.backgroundColor = RGB(48, 46, 58);
    [topView addSubview:self.topHeaderView];
    [self.view addSubview:topView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationSearch" object:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (CGFloat)topHeaderWidth{
    return ScreenWidth-32;
}

- (UIView*)createTopHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(16, 8, ScreenWidth -32, 44)];
    view.backgroundColor = RGB(48, 46, 58);
    return view;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
