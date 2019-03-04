//
//  SystemViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "SystemViewController.h"
#import "SystemTableViewCell.h"
#import "SystemDetailViewController.h"
@interface SystemViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    NSMutableArray *dataList;
    int page;
}
@end

@implementation SystemViewController


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
    [[ServiceForUser manager]postMethodName:@"mobile/member/system_log" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
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
    return 1;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return dataList.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"SystemTableViewCell";
    SystemTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (dataList.count>0) {
        NSDictionary *dict = dataList[indexPath.section];
        cell.dict = dict;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (dataList.count>0) {
        NSDictionary *dict = dataList[indexPath.section];
        return [SystemTableViewCell heightForSystemTableViewCell:dict];
    }
    else
        return 95;
}

//设置边距
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    view.backgroundColor = RGB(230, 230, 230);
    return view;
}


-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 5)];
    view.backgroundColor = RGB(230, 230, 230);
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 5;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
     [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (dataList.count>0) {
        NSDictionary *dict = dataList[indexPath.section];
        SystemDetailViewController *vc = [[SystemDetailViewController alloc]init];
        vc.dict = dict;
        [self.navigationController pushViewController:vc animated:YES];
    }
}


-(void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}


@end
