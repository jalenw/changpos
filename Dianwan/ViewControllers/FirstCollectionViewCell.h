//
//  FirstCollectionViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/8.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Charts/Charts.h"
#import "Dianwan-Swift.h"
@interface FirstCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet PieChartView *pieChartView;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (strong, nonatomic) NSDictionary *dict;
@property (strong, nonatomic) NSString *label;
@end
