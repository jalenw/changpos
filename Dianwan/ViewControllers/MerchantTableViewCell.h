//
//  MerchantTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Charts/Charts.h"
#import "Dianwan-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface MerchantTableViewCell : UITableViewCell
@property (strong,nonatomic) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;
@end

NS_ASSUME_NONNULL_END
