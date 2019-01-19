//
//  BusinessHandlingViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BusinessHandlingViewController.h"
#import "ApplyDetailViewController.h"
#import "ModifyRateAndPriceViewController.h"
#import "ApplyOweDeviceViewController.h"
@interface BusinessHandlingViewController ()

@end

@implementation BusinessHandlingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"业务申请";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBarButtonWithTitle:@"申请明细"];
}

- (void)rightbarButtonDidTap:(UIButton*)button
{
    ApplyDetailViewController *vc = [[ApplyDetailViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)menuAct:(UIButton *)sender {
    if (sender.tag==3) {
        ApplyOweDeviceViewController *vc = [[ApplyOweDeviceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        ModifyRateAndPriceViewController *vc = [[ModifyRateAndPriceViewController alloc]init];
        vc.type = sender.tag;
        [self.navigationController pushViewController:vc animated:YES];
    }
}
@end
