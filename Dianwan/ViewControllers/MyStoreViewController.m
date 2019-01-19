//
//  MyStoreViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MyStoreViewController.h"
#import "TransfersDetailViewController.h"
#import "StoreTableViewCell.h"
@interface MyStoreViewController ()
{
    NSArray *array;
}
@end

@implementation MyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的机具";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBarButtonWithTitle:@"调拨明细"];
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myMachine" params:nil block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            array = [[data safeDictionaryForKey:@"result"] safeArrayForKey:@"list"];
            [self.tableView reloadData];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

-(void)rightbarButtonDidTap:(UIButton *)button
{
    TransfersDetailViewController *tran = [[TransfersDetailViewController alloc]init];
    [self.navigationController pushViewController:tran animated:YES];
}
- (IBAction)confirmAct:(UIButton *)sender {
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"StoreTableViewCell";
    StoreTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    if (array.count>0) {
        NSDictionary *dict = array[indexPath.row];
        cell.dict = dict;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 173;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
