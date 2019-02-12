//
//  ApplyApproveViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/1.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ApplyApproveViewController.h"
#import "ApplyApproveTableViewCell.h"
#import "CheckDetailViewController.h"
@interface ApplyApproveViewController ()
{
    NSMutableArray *dataList;
}
@end

@implementation ApplyApproveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dataList = [[NSMutableArray alloc]init];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self refreshData];
}

-(void)refreshData
{
    [dataList removeAllObjects];
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    [param setValue:@(self.type) forKey:@"state"];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/get_sn_transfer_list" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            NSArray *dataArray = [data safeArrayForKey:@"result"];
            if(dataArray.count>0){
                [dataList addObjectsFromArray:dataArray];
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
    NSString *cellIdentifier = @"ApplyApproveTableViewCell";
    ApplyApproveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataList[indexPath.row];
    CheckDetailViewController *vc = [[CheckDetailViewController alloc]init];
    vc.transfer_id = [dict safeStringForKey:@"transfer_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
