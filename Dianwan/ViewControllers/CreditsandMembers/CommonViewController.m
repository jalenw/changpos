//
//  CommonViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/20.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "CommonViewController.h"
#import "CommonTableViewCell.h"

@interface CommonViewController ()
{
    NSMutableArray *dataList;
    int page;
}
@end

@implementation CommonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataList = [[NSMutableArray alloc]init];
    page = 1;
    [self refreshData];
    self.tableView.separatorStyle = UITableViewCellAccessoryNone;
    self.tableView.backgroundColor = RGB(48, 46, 58);
    self.view.backgroundColor = RGB(48, 46, 58);
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
}

-(void)refreshData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    [param setValue:@(page) forKey:@"page"];
     WEAKSELF
    [param setValue:self.type forKey:@"type"];
    [[ServiceForUser manager]postMethodName:@"mobile/memberpoints/pointslog" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (page==1) {
            [self.tableView headerEndRefreshing];
        }
        else
        {
            [self.tableView footerEndRefreshing];
        }
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            NSArray *dataArray = [result safeArrayForKey:@"log_list"];
            
            //返回总积分
            [[NSNotificationCenter defaultCenter] postNotificationName:@"allcountNot" object:[NSString stringWithFormat:@"%@",[result safeStringForKey:@"total_points"]]];
            if (dataArray.count>0) {
                [dataList addObjectsFromArray:dataArray];
            }
            else
            {
                [self.tableView.footer setState:MJRefreshFooterStateNoMoreData];
            }
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"CommonTableViewCell";
    CommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    return 90;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
@end
