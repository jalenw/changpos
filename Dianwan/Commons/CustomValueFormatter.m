//
//  CustomValueFormatter.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/25.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "CustomValueFormatter.h"

@implementation CustomValueFormatter
{
    NSArray *array;
}
- (id)initForArray:(NSArray *)a
{
    self = [super init];
    if (self)
    {
        array = a;
    }
    return self;
}
- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    NSDictionary *dict = [array objectAtIndex:(int)value];
    return [dict safeStringForKey:@"date"];
}
@end
