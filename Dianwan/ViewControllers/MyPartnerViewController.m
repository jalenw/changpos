//
//  MyPartnerViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MyPartnerViewController.h"
#import "PartnersViewController.h"
#import "MerchantViewController.h"
@interface MyPartnerViewController ()<UITextFieldDelegate>

@end

@implementation MyPartnerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    // Do any additional setup after loading the view from its nib.
}

- (NSArray<NSString *> *)buttonTitleArray{
    return @[@"商户",@"伙伴"];
}

- (BOOL)isAllowScroll{
    return NO;
}

- (void)setupControllers{
    self.scrollView.top = 0;
    self.scrollView.height = ScreenHeight-64;
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
            MerchantViewController *subController = [[MerchantViewController alloc] init];
            controller = subController;
            [self addChildViewController:controller];
            self.currentController = controller;
        }else if (i == 1){
            PartnersViewController *subController = [[PartnersViewController alloc] init];
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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [topView addSubview:self.topHeaderView];
    [self.view addSubview:topView];
    self.searchView.width = ScreenWidth-90;
    self.searchTf.returnKeyType = UIReturnKeySearch;
    self.searchTf.delegate = self;
    self.navigationItem.titleView = self.searchView;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"kNotificationSearch" object:textField.text];
    [textField resignFirstResponder];
    return YES;
}

- (CGFloat)topHeaderWidth{
    return ScreenWidth;
}

- (UIView*)createTopHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    return view;
}
- (CGFloat)indicatorOffset{
    return 0;
}

- (UIColor *)selectTabTextColor{
    return ThemeColor;
}

@end