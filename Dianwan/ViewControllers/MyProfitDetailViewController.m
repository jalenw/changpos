//
//  MyProfitDetailViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MyProfitDetailViewController.h"
#import "ProfitDetailTableViewCell.h"
@interface MyProfitDetailViewController ()
{
    NSMutableArray *dataList;
    int page;
    NSString *search_date_star;
    NSString *search_date_end;
}
@end

@implementation MyProfitDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"收益明细";
    self.tableView.tableHeaderView = self.headerView;
    dataList = [[NSMutableArray alloc]init];
    page = 1;
    [self refreshData];
    [self.tableView addLegendHeaderWithRefreshingBlock:^{
        page = 1;
        [dataList removeAllObjects];
        [self refreshData];
    }];
    [self.tableView addLegendFooterWithRefreshingBlock:^{
        page ++;
        [self refreshData];
    }];
    // Do any additional setup after loading the view from its nib.
}

-(void)refreshData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    [param setValue:@(page) forKey:@"page"];
    if (search_date_star) {
        [param setValue:search_date_star forKey:@"search_date_star"];
    }
    if (search_date_end) {
        [param setValue:search_date_end forKey:@"search_date_end"];
    }
    [[ServiceForUser manager]postMethodName:@"mobile/recharge/earnings_detail" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
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
            for ( NSDictionary *dataitem in dataArray) {
                [dataList addObject:dataitem];
            }
            [self.tableView reloadData];
            
            self.spendLb.text = [NSString stringWithFormat:@"￥%@",[[result safeDictionaryForKey:@"price_info"] safeStringForKey:@"spending"]];
            self.incomeLb.text = [NSString stringWithFormat:@"￥%@",[[result safeDictionaryForKey:@"price_info"] safeStringForKey:@"income"]];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"ProfitDetailTableViewCell";
    ProfitDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (dataList.count>0) {
        NSDictionary *dict = dataList[indexPath.row];
        cell.dict = dict;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 71;
}


- (IBAction)monthAct:(UIButton *)sender {
    search_date_star = nil;
    search_date_end = nil;
    
    page = 1;
    [dataList removeAllObjects];
    [self refreshData];
    
    [sender setTitle:@"本月" forState:UIControlStateNormal];
}

- (IBAction)chooseDateAct:(UIButton *)sender {
}
@end
