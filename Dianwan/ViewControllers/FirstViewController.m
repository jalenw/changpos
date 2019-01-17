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
@interface FirstViewController ()
{
    NSArray *adArray;
    NSDictionary *dict;
}
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"简单创业 轻松畅POS";
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth, 587)];
    [self.scrollView addLegendHeaderWithRefreshingBlock:^{
        [self getData];
    }];
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
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
    [[ServiceForUser manager]postMethodName:@"mobile/recharge/today_earnings" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
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
    if (indexPath.row==0) {
        [cell setDict:dict];
    }
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
@end
