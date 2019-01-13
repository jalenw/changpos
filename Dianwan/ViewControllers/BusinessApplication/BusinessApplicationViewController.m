//
//  BusinessApplicationViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/8.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "BusinessApplicationViewController.h"

@interface BusinessApplicationViewController ()

@end

@implementation BusinessApplicationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title=@"费率调整";
    self.view.backgroundColor =RGB(48, 46, 58);
    [self setRightBarButtonWithTitle:@"费改通知"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
