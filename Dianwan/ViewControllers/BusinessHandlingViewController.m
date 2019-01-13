//
//  BusinessHandlingViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BusinessHandlingViewController.h"
#import "ApplyDetailViewController.h"
@interface BusinessHandlingViewController ()

@end

@implementation BusinessHandlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"业务申请";
    [self setRightBarButtonWithTitle:@"申请明细"];
    // Do any additional setup after loading the view from its nib.
}

- (void)rightbarButtonDidTap:(UIButton*)button
{
    ApplyDetailViewController *vc = [[ApplyDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)menuAct:(UIButton *)sender {
}
@end
