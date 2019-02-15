//
//  StatisticTrendTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/29.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Charts/Charts.h"
#import "Dianwan-Swift.h"
#import "HooDatePicker.h"

@protocol StatisticTrendTableViewCellDelegate <NSObject>
-(void)showMoreInfoForCell:(NSIndexPath*)path;
@end
NS_ASSUME_NONNULL_BEGIN

@interface StatisticTrendTableViewCell : UITableViewCell<HooDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (nonatomic, strong) NSIndexPath *path;
@property (weak, nonatomic) IBOutlet BarChartView *chartView;
@property (weak, nonatomic) IBOutlet LineChartView *lineChartView;
@property (nonatomic, assign) id<StatisticTrendTableViewCellDelegate> delegate;

- (IBAction)showMoreAct:(UIButton *)sender;
- (IBAction)dateAct:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
