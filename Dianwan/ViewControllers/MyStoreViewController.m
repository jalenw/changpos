//
//  MyStoreViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MyStoreViewController.h"
#import "TransfersDetailViewController.h"
@interface MyStoreViewController ()

@end

@implementation MyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的机具";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBarButtonWithTitle:@"调拨明细"];
}

-(void)rightbarButtonDidTap:(UIButton *)button
{
    TransfersDetailViewController *tran = [[TransfersDetailViewController alloc]init];
    [self.navigationController pushViewController:tran animated:YES];
}
- (IBAction)confirmAct:(UIButton *)sender {
}
@end
