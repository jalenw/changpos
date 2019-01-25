//
//  CustomValueFormatter.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/25.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Charts/Charts.h"
#import "Dianwan-Swift.h"
NS_ASSUME_NONNULL_BEGIN

@interface CustomValueFormatter : NSObject<IChartAxisValueFormatter>
- (id)initForArray:(NSArray *)a;
@end

NS_ASSUME_NONNULL_END
