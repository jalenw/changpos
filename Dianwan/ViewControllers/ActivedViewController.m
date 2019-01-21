//
//  ActivedViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/20.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ActivedViewController.h"
#import "ToolTableViewCell.h"
#import "RoleViewController.h"
@interface ActivedViewController ()
{
    NSMutableArray *dataList;
//    int page;
}
@end

@implementation ActivedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keywordDidChange:) name:@"kNotificationSearch" object:nil];
    dataList = [[NSMutableArray alloc]init];
//    page = 1;
    [self refreshData];
    self.tableView.backgroundColor = RGB(48, 46, 58);
//    [self.tableView addLegendHeaderWithRefreshingBlock:^{
//        page = 1;
//        [dataList removeAllObjects];
//        [self refreshData];
//    }];
//    [self.tableView addLegendFooterWithRefreshingBlock:^{
//        page ++;
//        [self refreshData];
//    }];
    // Do any additional setup after loading the view from its nib.
}

- (void)keywordDidChange:(NSNotification *)notification
{
    self.keyword = notification.object;
//    page = 1;
    [dataList removeAllObjects];
    [self refreshData];
}

-(void)refreshData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (self.keyword.length>0) {
        [param setValue:self.keyword forKey:@"keyword"];
    }
    [param setValue:self.goods_id forKey:@"goods_id"];
    [param setValue:@"2" forKey:@"machine_type"];
    if (self.others_member_id) {
        [param setValue:self.others_member_id forKey:@"others_member_id"];
    }
//    [param setValue:@(page) forKey:@"page"];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myMachineToolsList" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
//        if (page==1) {
//            [self.tableView headerEndRefreshing];
//        }
//        else
//        {
//            [self.tableView footerEndRefreshing];
//        }
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            NSArray *dataArray = [result safeArrayForKey:@"list"];
            for ( NSDictionary *dataitem in dataArray) {
                [dataList addObject:dataitem];
            }
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"ToolTableViewCell";
    ToolTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    return 80;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = dataList[indexPath.row];
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (self.others_member_id) {
        [param setValue:self.others_member_id forKey:@"others_member_id"];
    }
    [param setValue:self.goods_id forKey:@"goods_id"];
    [param setValue:[dict safeStringForKey:@"sn_code"] forKey:@"sn_code"];
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myProductRateInfo" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            RoleViewController *vc = [[RoleViewController alloc]init];
            vc.snDict = [data safeDictionaryForKey:@"result"];
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
