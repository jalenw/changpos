//
//  MyFViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/9.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "MyFViewController.h"

@interface MyFViewController ()

@end

@implementation MyFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self navAction];
    // Do any additional setup after loading the view from its nib.
}

-(void)navAction{
    UISearchBar * searchbar =[[UISearchBar alloc]init];
    searchbar.placeholder =@"输入姓名,手机号,SN号";
    self.navigationItem.titleView =searchbar;
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
