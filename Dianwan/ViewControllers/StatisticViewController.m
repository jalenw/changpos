//
//  StatisticViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/6.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "StatisticViewController.h"
#import "FirstHeaderView.h"
#import "StatisticTotalTableViewCell.h"
#import "StatisticTrendTableViewCell.h"
@interface StatisticViewController () <StatisticTotalTableViewCellDelegate,StatisticTrendTableViewCellDelegate>
{
    NSIndexPath *selectedPath;
}
@end

@implementation StatisticViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"统计";
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        NSString *cellIdentifier = @"StatisticTotalTableViewCell";
        StatisticTotalTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.delegate = self;
        }
        if (selectedPath==indexPath) {
            cell.bt.selected = true;
        }
        else
        {
            cell.bt.selected = false;
        }
        cell.path = indexPath;
        return cell;
    }
    else
    {
        NSString *cellIdentifier = @"StatisticTrendTableViewCell";
        StatisticTrendTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        if(cell == nil){
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.delegate = self;
        }
        if (selectedPath==indexPath) {
            cell.bt.selected = true;
        }
        else
        {
            cell.bt.selected = false;
        }
        cell.path = indexPath;
        return cell;
    }
}

-(void)showMoreInfoForCell:(NSIndexPath*)path
{
    selectedPath = path;
    [self.tableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath == selectedPath) {
        if (indexPath.section==0) {
        return 281;
        }
        else
            return 316;
    }
    else
        return 44.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    static NSString *viewIdentfier = @"FirstHeaderView";
    FirstHeaderView *sectionHeadView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:viewIdentfier];
    if(!sectionHeadView){
        sectionHeadView = [[FirstHeaderView alloc] initWithReuseIdentifier:viewIdentfier];
    }
    if (section==0) {
        sectionHeadView.label.text = @"总量图";
    }
    if (section==1) {
        sectionHeadView.label.text = @"走势图";
    }
    return sectionHeadView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}

@end
