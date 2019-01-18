//
//  ApplyOweDeviceViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ApplyOweDeviceViewController.h"

@interface ApplyOweDeviceViewController ()

@end

@implementation ApplyOweDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请自备机入网";
    [self setupForDismissKeyboard];
    self.tableView.tableHeaderView = self.headView;
    // Do any additional setup after loading the view from its nib.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)confirmAct:(UIButton *)sender {
}
@end
