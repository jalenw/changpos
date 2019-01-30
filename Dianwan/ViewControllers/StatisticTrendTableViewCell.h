//
//  StatisticTrendTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/29.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol StatisticTrendTableViewCellDelegate <NSObject>
-(void)showMoreInfoForCell:(NSIndexPath*)path;
@end
NS_ASSUME_NONNULL_BEGIN

@interface StatisticTrendTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *bt;
@property (nonatomic, strong) NSIndexPath *path;
@property (nonatomic, assign) id<StatisticTrendTableViewCellDelegate> delegate;
- (IBAction)showMoreAct:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
