//
//  CreditsAndMembersViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/20.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "CreditsAndMembersViewController.h"

#import "PartnersViewController.h"
#import "MerchantViewController.h"
#import "CommonViewController.h"
@interface CreditsAndMembersViewController ()
@property (weak, nonatomic) IBOutlet UIView *titleview;

@end

@implementation CreditsAndMembersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    self.title =@"我的积分";
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(setcountAct:) name:@"allcountNot" object:nil];
    self.titleview.backgroundColor = RGB( 48, 46,58);
}
-(void)setcountAct:(NSNotification *)not{
     NSString *userinfo = not.object;
    self.allcountLabel.text  =userinfo;
}

- (NSArray<NSString *> *)buttonTitleArray{
    return @[@"签到",@"激活",@"交易",@"采购",@"发展"];
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
    return 30;
}

- (CGFloat)indicatorOffset{
    return (ScreenWidth/5-30)/2;
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
            CommonViewController *subController = [[CommonViewController alloc] init];
            subController.type = @"signin";
            controller = subController;
            [self addChildViewController:controller];
            self.currentController = controller;
        }else if (i == 1){
            CommonViewController *subController = [[CommonViewController alloc] init];
            subController.type = @"activation";
            controller = subController;
            [self addChildViewController:controller];
        }
        if(i == 2){
            CommonViewController *subController = [[CommonViewController alloc] init];
            subController.type = @"trading";
            controller = subController;
            [self addChildViewController:controller];
           
        }else if (i == 3){
            CommonViewController *subController = [[CommonViewController alloc] init];
            subController.type = @"order";
            controller = subController;
            [self addChildViewController:controller];
        }
        if(i == 4){
            CommonViewController *subController = [[CommonViewController alloc] init];
            subController.type = @"inviter";
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
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 160, ScreenWidth, 44)];
    [topView addSubview:self.topHeaderView];
    [self.view addSubview:topView];}



- (CGFloat)topHeaderWidth{
    return ScreenWidth;
}

- (UIView*)createTopHeaderView{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 44)];
    return view;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"allcountNot" object:self];
}

@end
