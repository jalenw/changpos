//
//  TeamProfitViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"
#import "Charts/Charts.h"
#import "Dianwan-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface TeamProfitViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIButton *weekBt;
@property (weak, nonatomic) IBOutlet UIButton *monthBt;
@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@property (weak, nonatomic) IBOutlet UILabel *todayLb;
- (IBAction)changeAct:(UIButton *)sender;
- (IBAction)dateAct:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
