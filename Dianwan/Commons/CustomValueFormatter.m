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
    NSString *endDate;
}
- (id)initForArray:(NSArray *)a endDate:(NSString*)e
{
    self = [super init];
    if (self)
    {
        array = a;
        endDate = e;
    }
    return self;
}
- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    if ([[array objectAtIndex:(int)value] isKindOfClass:[NSString class]]) {
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *e = [myDateFormatter dateFromString:endDate];
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"MM-dd";
        NSDateComponents *components = [[NSDateComponents alloc]init];
        components.day = -6+(int)value;
        NSDate *theDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:e options:0];
        NSString *date=[dateFormatter stringFromDate:theDate];
        return date;
    }
    else
    {
        NSDictionary *dict = [array objectAtIndex:(int)value];
        return [dict safeStringForKey:@"date"];
    }
}
@end
