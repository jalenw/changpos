//
//  StatisticTotalTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/29.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Charts/Charts.h"
#import "Dianwan-Swift.h"
@protocol StatisticTotalTableViewCellDelegate <NSObject>
-(void)showMoreInfoForCell:(NSIndexPath*_Nullable)path;
@end
NS_ASSUME_NONNULL_BEGIN

@interface StatisticTotalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (nonatomic, strong) NSIndexPath *path;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet PieChartView *chartView;
@property (weak, nonatomic) IBOutlet UILabel *chartLb;
@property (weak, nonatomic) IBOutlet PieChartView *chartView2;
@property (weak, nonatomic) IBOutlet UILabel *chartLb2;
@property (nonatomic, assign) id<StatisticTotalTableViewCellDelegate> delegate;
- (IBAction)showMoreAct:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
