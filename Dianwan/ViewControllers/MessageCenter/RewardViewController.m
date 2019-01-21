//
//  rewardViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "RewardViewController.h"
#import "RewardtableViewCell.h"

@interface RewardViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataList;
    int page;
}
@end

@implementation RewardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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
    [[ServiceForUser manager]postMethodName:@"mobile/member/reward_log" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
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
    NSString *cellIdentifier = @"RewardTableViewCell";
    RewardTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
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
    
    NSString *content = [dataList[indexPath.row] safeStringForKey:@"push_message"];
    CGFloat height= [Tooles sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(ScreenWidth-64, MAXFLOAT)  string:content].height;
   
         return 86+height+16;
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

@end
