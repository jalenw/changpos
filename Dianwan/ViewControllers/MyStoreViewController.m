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
#import "ActivedStoreViewController.h"
#import "AllocateViewController.h"
#import "RoleViewController.h"
@interface MyStoreViewController ()
{
    NSArray *array;
}
@end

@implementation MyStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.others_member_id) {
        self.title = @"伙伴的库存";
        self.bt.hidden = YES;
        self.tableView.frame = ScreenBounds;
    }
    else
        self.title = @"我的机具";
    // Do any additional setup after loading the view from its nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBarButtonWithTitle:@"调拨明细"];
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (self.others_member_id) {
        [param setValue:self.others_member_id forKey:@"others_member_id"];
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myMachine" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
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
    AllocateViewController *vc = [[AllocateViewController alloc]init];
//    if (self.others_member_id) {
//        vc.others_member_id = self.others_member_id;
//    }
    [self.navigationController pushViewController:vc animated:YES];
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
        [cell.roleBt addTarget:self action:@selector(roleAct:) forControlEvents:UIControlEventTouchUpInside];
    }
    if (array.count>0) {
        NSDictionary *dict = array[indexPath.row];
        cell.dict = dict;
        cell.roleBt.tag = indexPath.row;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 173;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dict = array[indexPath.row];
    ActivedStoreViewController *vc = [[ActivedStoreViewController alloc]init];
    if (self.others_member_id) {
        vc.others_member_id = self.others_member_id;
    }
    vc.goods_id = [dict safeStringForKey:@"goods_id"];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)roleAct:(UIButton*)button
{
    NSDictionary *dict = array[button.tag];
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (self.others_member_id) {
        [param setValue:self.others_member_id forKey:@"others_member_id"];
    }
    [param setValue:[dict safeStringForKey:@"goods_id"] forKey:@"goods_id"];
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myProductRateInfo" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            RoleViewController *vc = [[RoleViewController alloc]init];
            vc.dict = [data safeDictionaryForKey:@"result"];
            [self.navigationController pushViewController:vc animated:YES];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}
@end
