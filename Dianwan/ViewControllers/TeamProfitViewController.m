//
//  TeamProfitViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/23.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "TeamProfitViewController.h"
#import "HooDatePicker.h"
#import "CustomValueFormatter.h"
#import "BezierCurveView.h"
@interface TeamProfitViewController ()<HooDatePickerDelegate>
{
    NSDictionary *dict;
    NSString *date_type;
    HooDatePicker *beginDatePicker;
    NSString *search_date_star;
    NSString *search_date_end;
    
    BezierCurveView *_bezierView;
}
@end

@implementation TeamProfitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.weekBt setBackgroundImage:[Tooles createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [self.monthBt setBackgroundImage:[Tooles createImageWithColor:[UIColor lightGrayColor]] forState:UIControlStateNormal];
    [self.weekBt setBackgroundImage:[Tooles createImageWithColor:RGB(253, 210,88)] forState:UIControlStateSelected];
    [self.monthBt setBackgroundImage:[Tooles createImageWithColor:RGB(253, 210,88)] forState:UIControlStateSelected];
    self.weekBt.selected = true;
    date_type = @"week";
    
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    NSString *date_end =[dateFormatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = -6;
    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
    NSString *date_start =[dateFormatter stringFromDate:startDate];
    self.todayLb.text = [NSString stringWithFormat:@"%@至%@",date_start,date_end];
    [self getData];
}

- (void)setupLineChartView:(NSArray*)array
{
    
    _lineChartView.dragEnabled = YES;
    [_lineChartView setScaleEnabled:YES];
    _lineChartView.pinchZoomEnabled = YES;
    _lineChartView.drawGridBackgroundEnabled = NO;
    
//    _lineChartView.xAxis.gridLineDashLengths = @[@10.0, @10.0];
//    _lineChartView.xAxis.gridLineDashPhase = 0.f;
    
    ChartYAxis *leftAxis = _lineChartView.leftAxis;
    [leftAxis removeAllLimitLines];
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 2;
    leftAxisFormatter.negativeSuffix = @" ￥";
    leftAxisFormatter.positiveSuffix = @" ￥";
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.axisMinimum = 0;
//    leftAxis.gridLineDashLengths = @[@5.f, @5.f];
    leftAxis.drawZeroLineEnabled = YES;
    leftAxis.drawLimitLinesBehindDataEnabled = YES;
    
    ChartXAxis *xAxis = _lineChartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = YES;
    xAxis.granularity = 1.0;
    xAxis.labelCount = array.count;
    xAxis.valueFormatter = [[CustomValueFormatter alloc]initForArray:array endDate:@""];
    
    _lineChartView.rightAxis.enabled = NO;
    
    _chartView.legend.form = ChartLegendFormLine;
    
    [_lineChartView animateWithXAxisDuration:2.5];
    
//    chartView.chartDescription.enabled = NO;
//
//    chartView.drawGridBackgroundEnabled = NO;
//
//    chartView.dragEnabled = YES;
//    [chartView setScaleEnabled:YES];
//    chartView.pinchZoomEnabled = NO;
//
//    chartView.rightAxis.enabled = NO;
//
//    ChartXAxis *xAxis = _chartView.xAxis;
//    xAxis.labelPosition = XAxisLabelPositionBottom;
//    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
//    xAxis.drawGridLinesEnabled = YES;
//    xAxis.granularity = 1.0;
//    xAxis.labelCount = array.count;
//    xAxis.valueFormatter = [[CustomValueFormatter alloc]initForArray:array endDate:@""];
//
//    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
//    leftAxisFormatter.minimumFractionDigits = 0;
//    leftAxisFormatter.maximumFractionDigits = 2;
//    leftAxisFormatter.negativeSuffix = @" ￥";
//    leftAxisFormatter.positiveSuffix = @" ￥";
//
//    ChartYAxis *leftAxis = _chartView.leftAxis;
//    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
//    leftAxis.labelCount = 10;
//    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
//    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
//    leftAxis.spaceTop = 0.15;
//    leftAxis.axisMinimum = YES;
//
//    ChartLegend *l = _chartView.legend;
//    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
//    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
//    l.orientation = ChartLegendOrientationHorizontal;
//    l.drawInside = NO;
//    l.form = ChartLegendFormSquare;
//    l.formSize = 9.0;
//    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
//    l.xEntrySpace = 4.0;
}

-(void)getData
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (search_date_end) {
        [param setValue:search_date_end forKey:@"search_date_end"];
    }
    [param setValue:@"3" forKey:@"type"];
    [param setValue:date_type forKey:@"date_type"];
    [[ServiceForUser manager]postMethodName:@"mobile/recharge/my_earnings" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            dict = [data safeDictionaryForKey:@"result"];
            NSArray *array = [[dict safeDictionaryForKey:@"earnings_info"] safeArrayForKey:@"group_earnings"];
            
            [self setupLineChartView:array];
            
            double nowTotal = 0.00;
            
            NSMutableArray *values = [[NSMutableArray alloc] init];
            
            NSMutableArray *yVals = [[NSMutableArray alloc] init];
            NSMutableArray *xVals = [[NSMutableArray alloc] init];
            for (int i = 0; i < array.count; i++)
            {
                NSDictionary *tempDict = [array objectAtIndex:i];
                
                NSDateFormatter *myDateFormatter = [[NSDateFormatter alloc] init];
                [myDateFormatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *e ;
                 if (search_date_end) {
                     e = [myDateFormatter dateFromString:search_date_end];
                 }
                else
                     e = [NSDate date];
                NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
                dateFormatter.dateFormat=@"MM-dd";
                NSDateComponents *components = [[NSDateComponents alloc]init];
                components.day = -6+i;
                NSDate *theDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:e options:0];
                NSString *date=[dateFormatter stringFromDate:theDate];
                
                [xVals addObject:date];
                [yVals addObject:@([tempDict safeDoubleForKey:@"earnings"]/10000)];

                if ([tempDict safeDoubleForKey:@"earnings"]>0) {
                    nowTotal += [tempDict safeDoubleForKey:@"earnings"];
                }
                
                [values addObject:[[ChartDataEntry alloc] initWithX:i y:[tempDict safeDoubleForKey:@"earnings"]]];
            }
            self.totalLb.text = [NSString stringWithFormat:@"总收益:￥%.2f",nowTotal];
            
            LineChartDataSet *set1 = nil;
            if (_lineChartView.data.dataSetCount > 0)
            {
                set1 = (LineChartDataSet *)_lineChartView.data.dataSets[0];
                set1.values = values;
                [_lineChartView.data notifyDataChanged];
                [_lineChartView notifyDataSetChanged];
            }
            else
            {
                set1 = [[LineChartDataSet alloc] initWithValues:values label:@"团队收益"];
                
                set1.drawIconsEnabled = NO;
                
//                set1.lineDashLengths = @[@5.f, @2.5f];
//                set1.highlightLineDashLengths = @[@5.f, @2.5f];
                [set1 setColor:UIColor.blackColor];
                [set1 setCircleColor:UIColor.blackColor];
                set1.lineWidth = 1.0;
                set1.circleRadius = 3.0;
                set1.drawCircleHoleEnabled = NO;
                set1.valueFont = [UIFont systemFontOfSize:9.f];
//                set1.formLineDashLengths = @[@5.f, @2.5f];
                set1.formLineWidth = 1.0;
                set1.formSize = 15.0;
                
//                NSArray *gradientColors = @[
//                                            (id)[ChartColorTemplates colorFromString:@"#00ff0000"].CGColor,
//                                            (id)[ChartColorTemplates colorFromString:@"#ffff0000"].CGColor
//                                            ];
//                CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
//
//                set1.fillAlpha = 1.f;
//                set1.fill = [ChartFill fillWithLinearGradient:gradient angle:90.f];
//                set1.drawFilledEnabled = YES;
//                CGGradientRelease(gradient);
                
                NSMutableArray *dataSets = [[NSMutableArray alloc] init];
                [dataSets addObject:set1];
                
                LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
                
                _lineChartView.data = data;
            }
            
//            [_bezierView removeFromSuperview];
//            _bezierView = nil;
//            _bezierView = [BezierCurveView initWithFrame:CGRectMake(0, 10, ScreenWidth-20, self.chartView.height-10)];
//            [self.chartView addSubview:_bezierView];
//            // 多根折线图
//            [_bezierView drawMoreLineChartViewWithX_Value_Names:xVals TargetValues:(NSMutableArray *)@[yVals] LineType:LineType_Straight];
            
//            BarChartDataSet *set1 = nil;
//            set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"收益"];
//            [set1 setColor:RGB(253, 210,88)];
//                set1.drawIconsEnabled = NO;
//
//                NSMutableArray *dataSets = [[NSMutableArray alloc] init];
//                [dataSets addObject:set1];
//
//                BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
//                [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
//
//                data.barWidth = 0.9f;
//
//                _chartView.data = data;
        }
        else
        {
        }
    }];
}
- (IBAction)changeAct:(UIButton *)sender {
    self.weekBt.selected = NO;
    self.monthBt.selected = NO;
    sender.selected = YES;
    search_date_star = nil;
    search_date_end = nil;
    if (sender==self.weekBt) {
        date_type = @"week";
        NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
        dateFormatter.dateFormat=@"yyyy-MM-dd";
        NSString *date_end =[dateFormatter stringFromDate:[NSDate date]];
        NSDateComponents *components = [[NSDateComponents alloc]init];
        components.day = -6;
        NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
        NSString *date_start =[dateFormatter stringFromDate:startDate];
        self.todayLb.text = [NSString stringWithFormat:@"%@至%@",date_start,date_end];
    }
    if (sender==self.monthBt) {
        date_type = @"month";
        self.todayLb.text = [NSString stringWithFormat:@"本月"];
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
