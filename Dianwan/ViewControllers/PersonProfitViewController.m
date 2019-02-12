//
//  PersonProfitViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "PersonProfitViewController.h"
#import "HooDatePicker.h"
@interface PersonProfitViewController ()<HooDatePickerDelegate>
{
    NSDictionary *dict;
    NSString *date_type;
    HooDatePicker *beginDatePicker;
    NSString *search_date_star;
    NSString *search_date_end;
}
@end

@implementation PersonProfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.dayBt setBackgroundImage:[Tooles createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [self.weekBt setBackgroundImage:[Tooles createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [self.monthBt setBackgroundImage:[Tooles createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [self.dayBt setBackgroundImage:[Tooles createImageWithColor:RGB(253, 210,88)] forState:UIControlStateSelected];
    [self.weekBt setBackgroundImage:[Tooles createImageWithColor:RGB(253, 210,88)] forState:UIControlStateSelected];
    [self.monthBt setBackgroundImage:[Tooles createImageWithColor:RGB(253, 210,88)] forState:UIControlStateSelected];
    self.dayBt.selected = true;
    date_type = @"day";
    [self setupPieChartView:self.nowChartView];
    [self setupPieChartView:self.oldChartView];
    [self getData];
    [self.scrollView setContentSize:CGSizeMake(ScreenWidth, 460)];
}

- (void)setupPieChartView:(PieChartView *)chartView
{
    chartView.userInteractionEnabled = NO;
    chartView.usePercentValuesEnabled = NO;
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.4;
    chartView.transparentCircleRadiusPercent = 0.61;
    chartView.chartDescription.enabled = NO;
    [chartView setExtraOffsetsWithLeft:5.f top:10.f right:5.f bottom:5.f];
    
    chartView.drawCenterTextEnabled = YES;
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByTruncatingTail;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
    chartView.drawHoleEnabled = YES;
    chartView.rotationAngle = 0.0;
    chartView.rotationEnabled = YES;
    chartView.highlightPerTapEnabled = YES;
    chartView.drawEntryLabelsEnabled = NO;
    
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 10;
}

-(void)getData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (search_date_star) {
        [param setValue:search_date_star forKey:@"search_date_star"];
    }
    if (search_date_end) {
        [param setValue:search_date_end forKey:@"search_date_end"];
    }
    [param setValue:@"2" forKey:@"type"];
    [param setValue:date_type forKey:@"date_type"];
    [[ServiceForUser manager]postMethodName:@"mobile/recharge/my_earnings" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            dict = [data safeDictionaryForKey:@"result"];
            
            NSDictionary *nowDict = [[dict safeDictionaryForKey:@"earnings_info"] safeDictionaryForKey:@"now"];
            NSArray *array = [[[dict safeDictionaryForKey:@"earnings_info"] safeDictionaryForKey:@"now"] allKeys];
            NSMutableArray *entries = [[NSMutableArray alloc] init];
            BOOL hasData = false;
            double nowTotal = 0.00;
            for (int i = 0; i < array.count; i++)
            {
                NSString *key = [array objectAtIndex:i];
                double value = [nowDict safeDoubleForKey:key];
                NSString *label = [key isEqualToString:@"group_earnings"]?@"团队流水":[key isEqualToString:@"other_earnings"]?@"其他":[key isEqualToString:@"personal_activation"]?@"个人激活":[key isEqualToString:@"personal_earnings"]?@"个人流水":@"";
                if (value>0) {
                    [entries addObject:[[PieChartDataEntry alloc] initWithValue:value label:label]];
                    nowTotal += value;
                }
                if (value>0) {
                    hasData = true;
                }
            }
            self.todayTotalLb.text = [NSString stringWithFormat:@"总收益:￥%.2f",nowTotal];
            PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:entries label:@""];
            dataSet.sliceSpace = 2.0;
            NSMutableArray *colors = [[NSMutableArray alloc] init];
            [colors addObject:RGB(253, 210, 88)];
            [colors addObject:RGB(33, 115, 243)];
            [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
            dataSet.colors = colors;
            dataSet.valueLinePart1OffsetPercentage = 0.8;
            dataSet.valueLinePart1Length = 0.2;
            dataSet.valueLinePart2Length = 0.4;
            dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
            PieChartData *nowData = [[PieChartData alloc] initWithDataSet:dataSet];
            [nowData setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
            [nowData setValueTextColor:UIColor.blackColor];
            if(hasData){
            self.nowChartView.data = nowData;
            }
            else self.nowChartView.data = nil;
            
            NSDictionary *oldDict = [[dict safeDictionaryForKey:@"earnings_info"] safeDictionaryForKey:@"past"];
            NSArray *oldArray = [[[dict safeDictionaryForKey:@"earnings_info"] safeDictionaryForKey:@"past"] allKeys];
            NSMutableArray *oldEntries = [[NSMutableArray alloc] init];
            BOOL hasData2 = false;
            double oldTotal = 0.00;
            for (int i = 0; i < array.count; i++)
            {
                NSString *key = [oldArray objectAtIndex:i];
                double value = [oldDict safeDoubleForKey:key];
                NSString *label = [key isEqualToString:@"group_earnings"]?@"团队流水":[key isEqualToString:@"other_earnings"]?@"其他":[key isEqualToString:@"personal_activation"]?@"个人激活":[key isEqualToString:@"personal_earnings"]?@"个人流水":@"";
                if (value>0) {
                    [oldEntries addObject:[[PieChartDataEntry alloc] initWithValue:value label:label]];
                    oldTotal += value;
                }
                if (value>0) {
                    hasData2 = true;
                }
            }
            self.yesterdayTotalLb.text = [NSString stringWithFormat:@"总收益:￥%.2f",oldTotal];
            PieChartDataSet *oldDataSet = [[PieChartDataSet alloc] initWithValues:oldEntries label:@""];
            oldDataSet.sliceSpace = 2.0;
            oldDataSet.colors = colors;
            oldDataSet.valueLinePart1OffsetPercentage = 0.8;
            oldDataSet.valueLinePart1Length = 0.2;
            oldDataSet.valueLinePart2Length = 0.4;
            oldDataSet.yValuePosition = PieChartValuePositionOutsideSlice;
            PieChartData *oldData = [[PieChartData alloc] initWithDataSet:oldDataSet];
            [oldData setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
            [oldData setValueTextColor:UIColor.blackColor];
            if (hasData2) {
                self.oldChartView.data = oldData;
            }
            else self.oldChartView.data = nil;
        }
        else
        {
        }
    }];
}
- (IBAction)changeAct:(UIButton *)sender {
    self.oldChartView.hidden = NO;
    self.dayBt.selected = NO;
    self.weekBt.selected = NO;
    self.monthBt.selected = NO;
    sender.selected = YES;
    search_date_star = nil;
    search_date_end = nil;
    if (sender==self.dayBt) {
        date_type = @"day";
        self.todayLb.text = @"今日";
        self.yesterdayLb.text = @"昨日";
    }
    if (sender==self.weekBt) {
        date_type = @"week";
        
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        NSString *date_end =[dateFormatter stringFromDate:[NSDate date]];
        NSDateComponents *components = [[NSDateComponents alloc]init];
        components.day = -7;
        NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *date_start =[dateFormatter stringFromDate:startDate];
        components.day = -8;
        NSDate *passEndDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *passDate_end =[dateFormatter stringFromDate:passEndDate];
        components.day = -15;
        NSDate *passStartDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *passDate_start =[dateFormatter stringFromDate:passStartDate];
        self.todayLb.text = [NSString stringWithFormat:@"%@至%@",date_start,date_end];
        self.yesterdayLb.text = [NSString stringWithFormat:@"%@至%@",passDate_start,passDate_end];
    }
    if (sender==self.monthBt) {
        date_type = @"month";
        self.todayLb.text = [NSString stringWithFormat:@"本月"];
        self.yesterdayLb.text = [NSString stringWithFormat:@"上月"];
    }
    [self getData];
}

- (IBAction)dateAct:(UIButton *)sender {
    if (beginDatePicker==nil) {
        beginDatePicker = [[HooDatePicker alloc] initWithSuperView:self.view];
        beginDatePicker.delegate = self;
    }
    if ([date_type isEqualToString: @"month"]) {
        beginDatePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    }
    else
    {
        beginDatePicker.datePickerMode = HooDatePickerModeDate;
    }
    [beginDatePicker show];
}

- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate *)date
{
    self.oldChartView.hidden = YES;
    if ([date_type isEqualToString: @"day"]) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        search_date_end =[dateFormatter stringFromDate:date];
        search_date_star=[dateFormatter stringFromDate:date];
        
        self.todayLb.text = [NSString stringWithFormat:@"%@",search_date_end];
    }
    if ([date_type isEqualToString: @"week"]) {
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        search_date_end =[dateFormatter stringFromDate:date];
        NSDateComponents *components = [[NSDateComponents alloc]init];
        components.day = -6;
        NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:date options:0];
        search_date_star=[dateFormatter stringFromDate:startDate];
        
        self.todayLb.text = [NSString stringWithFormat:@"%@至%@",search_date_star,search_date_end];
    }
    if ([date_type isEqualToString: @"month"]) {
        NSDateFormatter *format=[[NSDateFormatter alloc] init];
        [format setDateFormat:@"yyyy-MM"];
        double interval = 0;
        NSDate *firstDate = nil;
        NSDate *lastDate = nil;
        NSCalendar *calendar = [NSCalendar currentCalendar];
        BOOL OK = [calendar rangeOfUnit:NSCalendarUnitMonth startDate:& firstDate interval:&interval forDate:date];
        if (OK) {
            lastDate = [firstDate dateByAddingTimeInterval:interval - 1];
        }else {
            return;
        }
        NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
        [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
        search_date_star = [myDateFormatter stringFromDate: firstDate];
        search_date_end = [myDateFormatter stringFromDate: lastDate];
        
        self.todayLb.text = [NSString stringWithFormat:@"%@",[format stringFromDate:date]];
    }
    [self getData];
}
@end
