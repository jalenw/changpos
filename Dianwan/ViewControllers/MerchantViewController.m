//
//  MerchantViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MerchantViewController.h"
#import "MerchantTableViewCell.h"
#import "RoleViewController.h"
@interface MerchantViewController ()
{
    NSMutableArray *dataList;
    int page;
}
@end

@implementation MerchantViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keywordDidChange:) name:@"kNotificationSearch" object:nil];
    dataList = [[NSMutableArray alloc]init];
    page = 1;
    [self refreshData];
    self.tableView.backgroundColor = RGB(48, 46, 58);
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        page = 1;
        [dataList removeAllObjects];
        [self refreshData];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        page ++;
        [self refreshData];
    }];
}

- (void)keywordDidChange:(NSNotification *)notification
{
    self.keyword = notification.object;
    page = 1;
    [dataList removeAllObjects];
    [self refreshData];
}

-(void)refreshData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (self.keyword.length>0) {
        [param setValue:self.keyword forKey:@"sn_code"];
    }
    [param setValue:@(page) forKey:@"page"];
     [param setValue:@(2.0) forKey:@"version"];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/listOfMyBusiness" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (page==1) {
            [self.tableView headerEndRefreshing];
        }
        else
        {
            [self.tableView footerEndRefreshing];
        }
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            NSArray *dataArray = [result safeArrayForKey:@"data"];
            for ( NSDictionary *dataitem in dataArray) {
                [dataList addObject:dataitem];
            }
            [[NSNotificationCenter defaultCenter]postNotificationName:@"kNotificationNumberOfMerchants" object:@(dataList.count)];
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"MerchantTableViewCell";
    MerchantTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.backgroundColor = RGB(48, 46, 58);
    }
    if (dataList.count>0) {
        NSDictionary *dict = dataList[indexPath.row];
        cell.dict = dict;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataList[indexPath.row];
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if ([dict safeStringForKey:@"member_id"]) {
        [param setValue:[dict safeStringForKey:@"member_id"] forKey:@"others_member_id"];
    }
    [param setValue:[dict safeStringForKey:@"goods_id"] forKey:@"goods_id"];
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myProductRateInfo" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            RoleViewController *vc = [[RoleViewController alloc]init];
            vc.dict = [data safeDictionaryForKey:@"result"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
