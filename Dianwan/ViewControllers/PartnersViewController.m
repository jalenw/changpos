//
//  PartnersViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "PartnersViewController.h"
#import "PartnersTableViewCell.h"
#import "MyStoreViewController.h"
@interface PartnersViewController ()
{
    NSMutableArray *dataList;
    int page;
}
@end

@implementation PartnersViewController

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
        [self.tableView.footer setState:MJRefreshFooterStateIdle];
        [self refreshData];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        page ++;
        [self refreshData];
    }];
    // Do any additional setup after loading the view from its nib.
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
        [param setValue:self.keyword forKey:@"search_key"];
    }
    [param setValue:@(2.0) forKey:@"version"];
    [param setValue:@(page) forKey:@"page"];
    [[ServiceForUser manager]postMethodName:@"mobile/member/my_partners_list" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (page==1) {
            [self.tableView headerEndRefreshing];
        }
        else
        {
            [self.tableView footerEndRefreshing];
        }
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            NSArray *dataArray = [result safeArrayForKey:@"list"];
            if (dataArray.count>0) {
                [dataList addObjectsFromArray:dataArray];
            }
            else
            {
                [self.tableView.footer setState:MJRefreshFooterStateNoMoreData];
            }
            if (dataList.count==0) {
                [self.tableView setEmptyView];
            }
            else
                [self.tableView removeEmptyView];
             [[NSNotificationCenter defaultCenter]postNotificationName:@"kNotificationNumberOfPartners" object:@(dataList.count)];
            
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"PartnersTableViewCell";
    PartnersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    return 229;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataList[indexPath.row];
    MyStoreViewController *vc = [[MyStoreViewController alloc]init];
    vc.others_member_id = [dict safeStringForKey:@"member_id"];
    [self.navigationController pushViewController:vc animated:YES];
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
@end
