//
//  MyProfitDetailViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MyProfitDetailViewController.h"
#import "ProfitDetailTableViewCell.h"
#import "HooDatePicker.h"
@interface MyProfitDetailViewController ()<HooDatePickerDelegate>
{
    NSMutableArray *dataList;
    int page;
    NSString *search_date_star;
    NSString *search_date_end;
    HooDatePicker *beginDatePicker;
    HooDatePicker *endDatePicker;
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
        [self.tableView.footer setState:MJRefreshFooterStateIdle];
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
            if (dataArray.count>0) {
                [dataList addObjectsFromArray:dataArray];
            }
            else
            {
                [self.tableView.footer setState:MJRefreshFooterStateNoMoreData];
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
    NSDictionary *dict = dataList[indexPath.row];
    return [ProfitDetailTableViewCell heightForProfitDetailTableViewCell:dict];
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
    if (beginDatePicker==nil) {
        beginDatePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
        [beginDatePicker setTitle:@"起始时间"];
        beginDatePicker.delegate = self;
        beginDatePicker.datePickerMode = HooDatePickerModeDate;
    }
    [beginDatePicker show];
}

- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate *)date
{
    if (datePicker==beginDatePicker) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        search_date_star =[dateFormatter stringFromDate:date];
        
        if (endDatePicker==nil) {
            endDatePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
            [endDatePicker setTitle:@"结束时间"];
            endDatePicker.delegate = self;
            endDatePicker.datePickerMode = HooDatePickerModeDate;
        }
        [endDatePicker show];
    }
    if (datePicker==endDatePicker) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        search_date_end =[dateFormatter stringFromDate:date];
        
        page = 1;
        [dataList removeAllObjects];
        [self refreshData];
        [self.monthBt setTitle:@"回到本月" forState:UIControlStateNormal];
    }
}
@end
