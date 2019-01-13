//
//  TrueNameViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/8.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "TrueNameViewController.h"
#import "TruenameView.h"

@interface TrueNameViewController ()
@property (strong, nonatomic) IBOutlet TruenameView *truenameview;
@end

@implementation TrueNameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   self.title = @"实名认证";
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    [scrollview addSubview:_truenameview];
    
    scrollview.contentSize = CGSizeMake(ScreenWidth,_truenameview.height+20);
    scrollview.showsHorizontalScrollIndicator =NO;
    scrollview.showsVerticalScrollIndicator =NO;
    [self.view addSubview:scrollview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
