//
//  BaseViewController.m
//  ShopFun
//
//  Created by noodle on 30/3/17.
//  Copyright © 2017年 intexh. All rights reserved.
//

#import "BaseViewController.h"
@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes: @{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:[UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]]}];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self setupNavigationItem];
}

- (void)setupNavigationItem{
    if (self.navigationController.viewControllers.firstObject != self
        && [self.navigationController.viewControllers containsObject:self])
    {
        UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        leftSpace.width = -20;
        UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
        [button setImage:[UIImage imageNamed:@"feihao_2"] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
        [self.navigationItem sx_setLeftBarButtonItem:backBarItem];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dismiss
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIButton*)setLeftBarButtonWithTitle:(NSString*)title{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//    [button addTarget:self action:@selector(leftbarButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = DefaultFontOfSize(18);
    [button setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]] forState:UIControlStateNormal];
    self.navigationItem.titleView = button;
    return button;
}

- (UIButton*)setRightBarButtonWithTitle:(NSString*)title{
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 80, 44)];
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(rightbarButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = DefaultFontOfSize(15);
    [button setTitleColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]] forState:UIControlStateNormal];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    [self.navigationItem sx_setRightBarButtonItems:@[rightBarItem]];
    return button;
}

- (UIButton *)setRightBarButtonWithImage:(UIImage *)image{
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftSpace.width = -15;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:self action:@selector(rightbarButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[leftSpace,rightBarItem];
    return button;
}

- (UIButton*)setLeftBarButtonWithImage:(UIImage*)image
{
    UIBarButtonItem *leftSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    leftSpace.width = -15;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [button setImage:image forState:UIControlStateNormal];
    
    [button addTarget:self action:@selector(leftbarButtonDidTap:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.leftBarButtonItems = @[leftSpace,rightBarItem];
    return button;
}

- (void)rightbarButtonDidTap:(UIButton*)button{
    
}

- (void)leftbarButtonDidTap:(UIButton*)button{
    
}
@end
