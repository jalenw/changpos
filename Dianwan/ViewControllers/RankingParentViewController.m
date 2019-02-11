//
//  RankingParentViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "RankingParentViewController.h"
#import "RunningWaterViewController.h"
#import "ActivationListViewController.h"
#import "ListDescriptionViewController.h"

@interface RankingParentViewController ()
@end

@implementation RankingParentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setRightBarButtonWithTitle:@"排行榜说明"];
}

- (NSArray<NSString *> *)buttonTitleArray{
    return @[@"激活榜",@"流水榜"];
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
    return RGB(241, 228, 142);
}


-(UIColor *)indicatorColor{
    return  RGB(251, 185, 55);}

-(CGFloat)indicatorWidth{
    return 80;
}

- (CGFloat)indicatorOffset{
    return (ScreenWidth/2-80)/2;
}

-(void)rightbarButtonDidTap:(UIButton *)button{
    ListDescriptionViewController *listDescription = [[ListDescriptionViewController alloc]init];
    [self.navigationController pushViewController:listDescription animated:YES];
}

- (void)setupControllers{
    self.scrollView.top = 0;
    self.title=@"排行榜";
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
            ActivationListViewController *subController = [[ActivationListViewController alloc] init];
            controller = subController;
            [self addChildViewController:controller];
             self.currentController = controller;
        }else if (i == 1){
      
            RunningWaterViewController *subController = [[RunningWaterViewController alloc] init];
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
