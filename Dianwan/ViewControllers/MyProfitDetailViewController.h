//
//  MyProfitDetailViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyProfitDetailViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UILabel *spendLb;
@property (weak, nonatomic) IBOutlet UILabel *incomeLb;
- (IBAction)monthAct:(UIButton *)sender;
- (IBAction)chooseDateAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
