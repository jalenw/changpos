//
//  ApplyCheckViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/1.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ApplyCheckViewController.h"
#import "ApplyApproveViewController.h"

@interface ApplyCheckViewController ()

@end

@implementation ApplyCheckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请审核列表";
    // Do any additional setup after loading the view from its nib.
}

- (NSArray<NSString *> *)buttonTitleArray{
    return @[@"未审核",@"已拒绝"];
}


-(UIColor *)BtnbackgroundColor{
    return RGB(48, 46, 58);
}

- (BOOL)isAllowScroll{
    return NO;
}
-(UIColor *)normalTabTextColor{
    return [UIColor whiteColor];
}

-(UIColor *)selectTabTextColor{
    return [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];//RGB(241, 228, 142);
}


-(UIColor *)indicatorColor{
    return  RGB(251, 185, 55);}

-(CGFloat)indicatorWidth{
    return 80;
}

- (CGFloat)indicatorOffset{
    return (ScreenWidth/2-80)/2;
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
            ApplyApproveViewController *subController = [[ApplyApproveViewController alloc] init];
            subController.type = 0;
            controller = subController;
            [self addChildViewController:controller];
            self.currentController = controller;
        }else if (i == 1){
            ApplyApproveViewController *subController = [[ApplyApproveViewController alloc] init];
            subController.type = 2;
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
}

- (CGFloat)topHeaderWidth{
    return ScreenWidth;
}

- (UIView*)createTopHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    return view;
}
@end
