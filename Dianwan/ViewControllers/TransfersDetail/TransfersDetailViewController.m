//
//  TransfersDetailViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "TransfersDetailViewController.h"
#import "TransfersViewController.h"
#import "TransfresTableViewCell.h"

@interface TransfersDetailViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataList;
    int page;
}
@property (weak, nonatomic) IBOutlet UITableView *mainTableview;

@end

@implementation TransfersDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"申请列表";
    dataList = [[NSMutableArray alloc]init];
    page = 1;
    [self refreshData];
    self.mainTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.mainTableview.backgroundColor = RGB(48, 46, 58);
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
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/allocationLogList" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
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
    NSString *cellIdentifier = @"TransfresTableViewCell";
    TransfresTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    return 135;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    TransfersViewController *transfers = [[TransfersViewController alloc]init];
    transfers.dict = dataList[indexPath.row];
    [self.navigationController pushViewController:transfers animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
