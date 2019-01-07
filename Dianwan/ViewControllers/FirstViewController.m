//
//  FirstViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2018/8/1.
//  Copyright © 2018年 intexh. All rights reserved.
//

#import "FirstViewController.h"
#import "QRViewController.h"
#import "NavigationMapViewViewController.h"
//#import <MediaPlayer/MediaPlayer.h> 视频播放
@interface FirstViewController ()<QRViewControllerDelegate>
{
    NSArray *adArray;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"简单创业 轻松畅POS";
//    [self setLeftBarButtonWithImage:[UIImage imageNamed:@"first_qr"]];
//    [self setRightBarButtonWithTitle:@"导航"];
    [self setupAdView];
    [self.adView setBlock:^(NSInteger index){
//        NSDictionary *dict = [adArray objectAtIndex:index];
//        CommonUIWebViewController *controller = [[CommonUIWebViewController alloc] init];
//        controller.address = [dict safeStringForKey:@"url"];
//        controller.showNav = YES;
//        [self.navigationController pushViewController:controller animated:YES];
    }];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

//-(void)leftbarButtonDidTap:(UIButton *)button
//{
//    QRViewController *vc = [[QRViewController alloc]init];
//    vc.delegate = self;
//    [self.navigationController pushViewController:vc animated:YES];
//}
//
//-(void)rightbarButtonDidTap:(UIButton *)button
//{
//    NavigationMapViewViewController *controller = [[NavigationMapViewViewController alloc] init];
//    CLLocationCoordinate2D navCoordinate;
//    navCoordinate.latitude = 39.92;
//    navCoordinate.longitude = 116.46;
//    controller.naviCoords = navCoordinate;
//    [self.navigationController pushViewController:controller animated:YES];
//}
//
//-(void)qrReturnString:(NSString*)str
//{
//    CommonUIWebViewController *controller = [[CommonUIWebViewController alloc] init];
//    controller.address = str;
//    [self.navigationController pushViewController:controller animated:YES];
//}

//获取首页广告
-(void)setupAdView
{
    [[ServiceForUser manager]postMethodName:@"mobile/index/index" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            adArray = [[data safeDictionaryForKey:@"result"] safeArrayForKey:@"adv_list"];
            NSMutableArray *picArray = [[NSMutableArray alloc]init];
            for (NSDictionary *dict in adArray) {
                [picArray addObject:[dict safeStringForKey:@"adv_code"]];
            }
            [self.adView setArray:picArray];
        }
    }];
}

//视频播放
//MPMoviePlayerViewController *mPMoviePlayerViewController;
//mPMoviePlayerViewController = [[MPMoviePlayerViewController alloc]initWithContentURL:[NSURL URLWithString:@"播放地址"]];
//mPMoviePlayerViewController.view.frame = ScreenBounds;
//[self presentViewController:mPMoviePlayerViewController animated:YES completion:nil];

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
