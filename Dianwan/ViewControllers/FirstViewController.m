//
//  FirstViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2018/8/1.
//  Copyright © 2018年 intexh. All rights reserved.
//

#import "FirstViewController.h"
#import "NavigationMapViewViewController.h"
#import "FirstCollectionViewCell.h"
#import "BusinessHandlingViewController.h"
#import "MyPartnerViewController.h"
#import "MyStoreViewController.h"
#import "RankingParentViewController.h"
#import "MyProfitViewController.h"
@interface FirstViewController ()
{
    NSArray *adArray;
    NSDictionary *dict;
    NSInteger hour;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.navigationItem.title = @"简单创业 轻松畅POS";
    
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth, 587)];
    [self.scrollView addLegendHeaderWithRefreshingBlock:^{
        [self getData];
    }];
    [self setupAdView];
    [self.adView setBlock:^(NSInteger index){
//        NSDictionary *dict = [adArray objectAtIndex:index];
//        CommonUIWebViewController *controller = [[CommonUIWebViewController alloc] init];
//        controller.address = [dict safeStringForKey:@"url"];
//        controller.showNav = YES;
//        [self.navigationController pushViewController:controller animated:YES];
    }];
    
    UICollectionViewFlowLayout *_layout = [[UICollectionViewFlowLayout alloc]init];
    _layout.itemSize = CGSizeMake(ScreenWidth,200);
    _layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _layout.minimumLineSpacing = 0;
    _layout.minimumInteritemSpacing = 0;
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    [self.collectionView setCollectionViewLayout:_layout];
    UINib *nib = [UINib nibWithNibName:@"FirstCollectionViewCell"
                                bundle: [NSBundle mainBundle]];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"FirstCollectionViewCell"];
    self.collectionView.scrollEnabled = NO;
    self.collectionView.contentSize = CGSizeMake(ScreenWidth*3, self.collectionView.height);
    UISwipeGestureRecognizer * swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [self.collectionView addGestureRecognizer:swipeRight];
    
    UISwipeGestureRecognizer * swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeGesture:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.collectionView addGestureRecognizer:swipeLeft];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH"];
    NSDate *datenow = [NSDate date];
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    hour = [currentTimeString integerValue];
    NSString *titleTip;
    if(hour>=6&&hour<8)
    {
        titleTip = @"早上好";
    } else if (hour >=8 &&hour <11)
    {
        titleTip = @"上午好";
    }else if (hour >=11 &&hour <13)
    {
        titleTip = @"中午好";
    }else if (hour >=13 &&hour <18)
    {
        titleTip = @"下午好";
    }else titleTip = @"晚上好";
    if (AppDelegateInstance.defaultUser.is_approve == 1) {
        self.navigationItem.title = [NSString stringWithFormat:@"%@,%@",titleTip,AppDelegateInstance.defaultUser.member_name];
    }
    else
    {
        self.navigationItem.title = @"你还没认证，请前往认证";
    }
    
    [self getData];
}

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

-(void)getData
{
    [[ServiceForUser manager]postMethodName:@"mobile/recharge/today_earnings" params:@{@"version":@"2.0"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [self.scrollView headerEndRefreshing];
        if (status) {
            dict = [data safeDictionaryForKey:@"result"];
            self.rankTurnover.text = [NSString stringWithFormat:@"%@",[[dict safeDictionaryForKey:@"top_info"] safeStringForKey:@"trading"]];
            self.rankActivity.text = [NSString stringWithFormat:@"%@",[[dict safeDictionaryForKey:@"top_info"] safeStringForKey:@"activation"]];
            [self.collectionView reloadData];
        }
    }];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FirstCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier: @"FirstCollectionViewCell" forIndexPath:indexPath];
       NSArray *array = [[dict safeDictionaryForKey:@"earnings_info"] safeArrayForKey:@"now"];
    if (array.count>0) {
        NSDictionary *now = [array objectAtIndex:indexPath.row];
        [cell setDict:now];
        if (indexPath.row==0) {
            [cell setLabel:[NSString stringWithFormat:@"收益:￥%@",[[dict safeDictionaryForKey:@"price"] safeStringForKey:@"available"].length>0?[[dict safeDictionaryForKey:@"price"] safeStringForKey:@"available"]:@""]];
        }
        if (indexPath.row==1) {
            [cell setLabel:[NSString stringWithFormat:@"激活量:%d台",[now safeIntForKey:@"group_activation"]+[now safeIntForKey:@"personal_activation"]]];
        }
        if (indexPath.row==2) {
            [cell setLabel:[NSString stringWithFormat:@"交易量:￥%.2f",[now safeDoubleForKey:@"group_trading"]+[now safeDoubleForKey:@"personal_trading"]]];
        }
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)rankinglistAct:(UIButton *)sender {
    RankingParentViewController *ranking =[[RankingParentViewController alloc]init];
    [self.navigationController pushViewController:ranking animated:YES];
    
}

- (IBAction)moreAct:(UIButton *)sender {
    MyProfitViewController *vc = [[MyProfitViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)menuAct:(UIButton *)sender {
    if (sender.tag==0) {
        CommonUIWebViewController *controller = [[CommonUIWebViewController alloc] init];
        controller.address = [NSString stringWithFormat:@"%@%@?isBack=true",web_url,@"signIn"];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (sender.tag==1) {
        MyPartnerViewController *controller = [[MyPartnerViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (sender.tag==2) {
        MyStoreViewController *controller = [[MyStoreViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
    if (sender.tag==3) {
        BusinessHandlingViewController *controller = [[BusinessHandlingViewController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void)handleSwipeGesture:(UISwipeGestureRecognizer *)swipeGesture {
    UISwipeGestureRecognizer *gesture = swipeGesture;
    NSInteger width = ScreenWidth;
    // 计算当前滑动的cell的索引
    CGPoint point = [gesture locationInView:self.collectionView];
    NSInteger index = point.x / width;
    // 将点转化为window上的点，计算该点在当前屏幕上的x坐标
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGPoint windowPoint = [self.view convertPoint:point toView:window];
    NSInteger x = (NSInteger)windowPoint.x % (NSInteger)ScreenWidth;
    if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        // 右划特殊考虑最后一个
        if (index <= 3-2 && x < width){
            index = index + 1;
        }
    } else if (swipeGesture.direction == UISwipeGestureRecognizerDirectionRight){
        // 左划特殊考虑第一个和倒数第二个
        if (index > 0){
            if (self.collectionView.contentOffset.x > width*(3-2) && index == 3 -2) {
                NSLog(@"这是在最后一页左划倒数第二个item,index不变");
            } else {
                if (x <= 0){
                }else if ((x > 0 && x < width)||index == 1) {
                    index = index - 1;
                } else {
                    index = index - 2;
                }
            }
        }
    }
    
    if (index == 3-1) { // 往最后一个页面滑动
        [UIView animateWithDuration:0.3 animations:^{
            [self.collectionView setContentOffset:CGPointMake(width*index, 0) animated:YES];
        }];
    } else {
        [UIView animateWithDuration:0.3 animations:^{
            [self.collectionView setContentOffset:CGPointMake(width*index, 0) animated:YES];
        }];
    }
    self.pageControl.currentPage = index;
}
@end
