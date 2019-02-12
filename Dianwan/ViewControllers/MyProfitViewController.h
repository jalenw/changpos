//
//  MyProfitViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "LZHTabScrollViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyProfitViewController : LZHTabScrollViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;
@property (weak, nonatomic) IBOutlet UILabel *freezeLb;
@property (weak, nonatomic) IBOutlet UIView *bgView;
- (IBAction)getMoneyAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
