//
//  RunningWaterViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "RunningWaterViewController.h"
#import "RunningWaterTableViewCell.h"
#import "FirstTableViewCell.h"
@interface RunningWaterViewController ()
{
    NSMutableArray *dataList;
    int page;
}
@property(nonatomic,strong)NSDictionary *myRanlist;
@end

@implementation RunningWaterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.separatorStyle = UITableViewCellEditingStyleNone;
    dataList = [[NSMutableArray alloc]init];
    page = 1;
    [self refreshData];
    self.tableView.backgroundColor =RGB(48, 46, 58);
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

    [param setValue:@"trading" forKey:@"type"];
    [[ServiceForUser manager]postMethodName:@"mobile/recharge/earnings_ranking" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (page==1) {
            [self.tableView headerEndRefreshing];
        }
        else
        {
            [self.tableView footerEndRefreshing];
        }
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            
            self.myRanlist = [data safeDictionaryForKey:@"my_ranking"];
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
            [self.tableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(dataList.count>0){
         return dataList.count+1;
    }else{
         return dataList.count ;
    }
   
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        FirstTableViewCell *cell = [[NSBundle mainBundle] loadNibNamed:@"FirstTableViewCell" owner:self options:nil][0];
       
            cell.dict = self.myRanlist;
        return cell;
    }else{
    NSString *cellIdentifier = @"RunningWaterTableViewCell";
    RunningWaterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
        NSDictionary *dict = dataList[indexPath.row -1];
        cell.dict = dict;
    return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row==0){
        return 90;
    }else{
        return 60;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
