//
//  SystemDetailViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/18.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "SystemDetailViewController.h"

@interface SystemDetailViewController ()

@end

@implementation SystemDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统详情";
    self.name.text = [self.dict safeStringForKey:@"push_title"];
    self.content.text = [self.dict safeStringForKey:@"push_message"];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.content sizeToFit];
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth, self.content.bottom+8)];
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
