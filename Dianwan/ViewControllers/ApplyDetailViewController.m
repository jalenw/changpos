//
//  ApplyDetailViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/11.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ApplyDetailViewController.h"
#import "ApplyDetailTableViewCell.h"
#import "ApplyShowDetailViewController.h"
@interface ApplyDetailViewController ()
{
    NSMutableArray *dataList;
    int page;
}
@end

@implementation ApplyDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"费改通知";
    dataList = [[NSMutableArray alloc]init];
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

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    page = 1;
    [dataList removeAllObjects];
    [self refreshData];
}

-(void)refreshData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    [param setValue:@(page) forKey:@"page"];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/examineAllocationInfo" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (page==1) {
            [self.tableView headerEndRefreshing];
        }
        else
        {
            [self.tableView footerEndRefreshing];
        }
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            NSArray *data = [result safeArrayForKey:@"data"];
            if (data.count>0) {
                [dataList addObjectsFromArray:data];
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
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"ApplyDetailTableViewCell";
    ApplyDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    return 105;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ApplyShowDetailViewController *applyshow = [[ApplyShowDetailViewController alloc]init];
    applyshow.idNum =[dataList[indexPath.row] safeIntForKey:@"id"];
    [self.navigationController pushViewController:applyshow animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
