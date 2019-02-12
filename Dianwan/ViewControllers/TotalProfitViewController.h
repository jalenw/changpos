//
//  TotalProfitViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"
#import "Charts/Charts.h"
#import "Dianwan-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface TotalProfitViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *dayBt;
@property (weak, nonatomic) IBOutlet UIButton *weekBt;
@property (weak, nonatomic) IBOutlet UIButton *monthBt;
@property (weak, nonatomic) IBOutlet PieChartView *nowChartView;
@property (weak, nonatomic) IBOutlet PieChartView *oldChartView;
@property (weak, nonatomic) IBOutlet UILabel *todayLb;
@property (weak, nonatomic) IBOutlet UILabel *todayTotalLb;
@property (weak, nonatomic) IBOutlet UILabel *yesterdayLb;
@property (weak, nonatomic) IBOutlet UILabel *yesterdayTotalLb;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)changeAct:(UIButton *)sender;
- (IBAction)dateAct:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
