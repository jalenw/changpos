//
//  StatisticTrendTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/29.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "StatisticTrendTableViewCell.h"
#import "CustomValueFormatter.h"

@implementation StatisticTrendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setupBarLineChartView:(BarLineChartViewBase *)chartView array:(NSArray*)array endDate:(NSString*)endDate
{
    chartView.chartDescription.enabled = NO;
    
    chartView.drawGridBackgroundEnabled = NO;
    
    chartView.dragEnabled = YES;
    [chartView setScaleEnabled:YES];
    chartView.pinchZoomEnabled = NO;
    
    chartView.rightAxis.enabled = NO;
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10.f];
    xAxis.drawGridLinesEnabled = YES;
    xAxis.granularity = 1.0;
    xAxis.labelCount = array.count;
    xAxis.valueFormatter = [[CustomValueFormatter alloc]initForArray:array endDate:endDate];
    
    NSNumberFormatter *leftAxisFormatter = [[NSNumberFormatter alloc] init];
    leftAxisFormatter.minimumFractionDigits = 0;
    leftAxisFormatter.maximumFractionDigits = 2;
    if (self.path.row==0) {
        leftAxisFormatter.negativeSuffix = @" ￥";
        leftAxisFormatter.positiveSuffix = @" ￥";
    }
    if (self.path.row==1) {
        leftAxisFormatter.negativeSuffix = @" 台";
        leftAxisFormatter.positiveSuffix = @" 台";
    }
    if (self.path.row==2) {
        leftAxisFormatter.negativeSuffix = @" ￥";
        leftAxisFormatter.positiveSuffix = @" ￥";
    }

    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.labelFont = [UIFont systemFontOfSize:10.f];
    leftAxis.labelCount = 10;
    leftAxis.valueFormatter = [[ChartDefaultAxisValueFormatter alloc] initWithFormatter:leftAxisFormatter];
    leftAxis.labelPosition = YAxisLabelPositionOutsideChart;
    leftAxis.spaceTop = 0.15;
    leftAxis.axisMinimum = YES;
    
    ChartLegend *l = _chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentLeft;
    l.verticalAlignment = ChartLegendVerticalAlignmentBottom;
    l.orientation = ChartLegendOrientationHorizontal;
    l.drawInside = NO;
    l.form = ChartLegendFormSquare;
    l.formSize = 9.0;
    l.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f];
    l.xEntrySpace = 4.0;
}

-(void)setPath:(NSIndexPath *)path
{
    _path = path;
    if (path.row==0) {
        self.img.image = [UIImage imageNamed:@"交易量"];
    }
    if (path.row==1) {
        self.img.image = [UIImage imageNamed:@"激活量"];
    }
    if (path.row==2) {
        self.img.image = [UIImage imageNamed:@"总收益"];
    }
    
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    NSString *search_date_end =[dateFormatter stringFromDate:[NSDate date]];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = -6;
    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
    NSString *search_date_star=[dateFormatter stringFromDate:startDate];
    if (search_date_star) {
        [param setValue:search_date_star forKey:@"search_date_star"];
    }
    if (search_date_end) {
        [param setValue:search_date_end forKey:@"search_date_end"];
    }
    [param setValue:@(self.path.row+1) forKey:@"type"];
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Statistics/my_trend" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            NSDictionary *personalDict = [[data safeDictionaryForKey:@"result"] safeDictionaryForKey:@"personal"];
            NSDictionary *groupDict = [[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"group"];
            if (personalDict) {
                NSArray *array = [personalDict allKeys];
                [self setupBarLineChartView:self.chartView array:array endDate:search_date_end];
                
                NSMutableArray *yVals = [[NSMutableArray alloc] init];
                for (int i = 0; i < array.count; i++)
                {
                    NSString *key = [array objectAtIndex:i];
                    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:[personalDict safeDoubleForKey:key]]];
                }
                
                BarChartDataSet *set1 = nil;
                
                set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"个人"];
                
                [set1 setColor:RGB(253, 210,88)];
                set1.drawIconsEnabled = NO;
                
                NSMutableArray *dataSets = [[NSMutableArray alloc] init];
                [dataSets addObject:set1];
                
               BarChartDataSet *set2 = nil;
                if (groupDict) {
                    NSArray *array = [groupDict allKeys];
                    [self setupBarLineChartView:self.chartView array:array endDate:search_date_end];
                    
                    NSMutableArray *yVals = [[NSMutableArray alloc] init];
                    for (int i = 0; i < array.count; i++)
                    {
                        NSString *key = [array objectAtIndex:i];
                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:[personalDict safeDoubleForKey:key]]];
                    }
                    
                    set2 = [[BarChartDataSet alloc] initWithValues:yVals label:@"团队"];
                    
                    [set2 setColor:RGB(253, 110,88)];
                    set2.drawIconsEnabled = NO;
                    [dataSets addObject:set2];
                }
        
                BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
                [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
                
                data.barWidth = 0.9f;
                _chartView.data = data;
            }
        }
    }];
}

- (IBAction)showMoreAct:(UIButton *)sender {
    [self.delegate showMoreInfoForCell:self.path];
}

- (IBAction)dateAct:(UIButton *)sender {
    HooDatePicker *beginDatePicker = [[HooDatePicker alloc] initWithSuperView:AppDelegateInstance.window];
    beginDatePicker.delegate = self;
    beginDatePicker.datePickerMode = HooDatePickerModeDate;
    [beginDatePicker show];
}

- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate *)date
{
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    NSString *search_date_end =[dateFormatter stringFromDate:date];
    NSDateComponents *components = [[NSDateComponents alloc]init];
    components.day = -6;
    NSDate *startDate = [[NSCalendar currentCalendar] dateByAddingComponents:components toDate:[NSDate date] options:0];
    NSString *search_date_star=[dateFormatter stringFromDate:startDate];
    if (search_date_star) {
        [param setValue:search_date_star forKey:@"search_date_star"];
    }
    if (search_date_end) {
        [param setValue:search_date_end forKey:@"search_date_end"];
    }
    [param setValue:@(self.path.row+1) forKey:@"type"];
    [[ServiceForUser manager]postMethodName:@"mobile/Statistics/my_trend" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            NSDictionary *personalDict = [[data safeDictionaryForKey:@"result"] safeDictionaryForKey:@"personal"];
            NSDictionary *groupDict = [[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"group"];
            if (personalDict) {
                NSArray *array = [personalDict allKeys];
                [self setupBarLineChartView:self.chartView array:array endDate:search_date_end];
                
                NSMutableArray *yVals = [[NSMutableArray alloc] init];
                for (int i = 0; i < array.count; i++)
                {
                    NSString *key = [array objectAtIndex:i];
                    [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:[personalDict safeDoubleForKey:key]]];
                }
                
                BarChartDataSet *set1 = nil;
                
                set1 = [[BarChartDataSet alloc] initWithValues:yVals label:@"个人"];
                
                [set1 setColor:RGB(253, 210,88)];
                set1.drawIconsEnabled = NO;
                
                NSMutableArray *dataSets = [[NSMutableArray alloc] init];
                [dataSets addObject:set1];
                
                BarChartDataSet *set2 = nil;
                if (groupDict) {
                    NSArray *array = [groupDict allKeys];
                    [self setupBarLineChartView:self.chartView array:array endDate:search_date_end];
                    
                    NSMutableArray *yVals = [[NSMutableArray alloc] init];
                    for (int i = 0; i < array.count; i++)
                    {
                        NSString *key = [array objectAtIndex:i];
                        [yVals addObject:[[BarChartDataEntry alloc] initWithX:i y:[personalDict safeDoubleForKey:key]]];
                    }
                    
                    set2 = [[BarChartDataSet alloc] initWithValues:yVals label:@"团队"];
                    
                    [set2 setColor:RGB(253, 110,88)];
                    set2.drawIconsEnabled = NO;
                    [dataSets addObject:set2];
                }
                
                BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
                [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
                
                data.barWidth = 0.9f;
                _chartView.data = data;
            }
        }
    }];
}
@end
