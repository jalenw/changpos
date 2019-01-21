//
//  withdrawalViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "WithdrawalViewController.h"
#import "WithdrawalTableViewCell.h"
#import "ShowWithdrawaldetailsViewController.h"
@interface WithdrawalViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataList;
    int page;
}

@end

@implementation WithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataList = [[NSMutableArray alloc]init];
    page = 1;
    [self refreshData];
    self.mainTableview.backgroundColor = RGB(48, 46, 58);
    self.mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.mainTableview addLegendHeaderWithRefreshingBlock:^{
        page = 1;
        [dataList removeAllObjects];
        [self refreshData];
    }];
    [self.mainTableview addLegendFooterWithRefreshingBlock:^{
        page ++;
        [self refreshData];
    }];
}


-(void)refreshData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    
    [param setValue:@(page) forKey:@"page"];
    [[ServiceForUser manager]postMethodName:@"mobile/member/pd_cash_list" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (page==1) {
            [self.mainTableview headerEndRefreshing];
        }
        else
        {
            [self.mainTableview footerEndRefreshing];
        }
        if (status) {
            NSArray *dataArray = [data safeArrayForKey:@"result"];
            for ( NSDictionary *dataitem in dataArray) {
                [dataList addObject:dataitem];
            }
            [self.mainTableview reloadData];
        }else
            [AlertHelper showAlertWithTitle:error];
    }];
}

#pragma mark ---datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"WithdrawalTableViewCell";
    WithdrawalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        
//        cell.backgroundColor = RGB(48, 46, 58);
    }
    if (dataList.count>0) {
        NSDictionary *dict = dataList[indexPath.row];
        cell.dict = dict;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 255;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ShowWithdrawaldetailsViewController *Showdetail = [[ShowWithdrawaldetailsViewController alloc]init];
    Showdetail.dict =dataList[indexPath.row];
    [self.navigationController pushViewController:Showdetail animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
