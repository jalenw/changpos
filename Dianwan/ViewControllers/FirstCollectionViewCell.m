//
//  FirstCollectionViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/8.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "FirstCollectionViewCell.h"

@implementation FirstCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setupPieChartView:self.pieChartView];
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
    
//    NSMutableAttributedString *centerText = [[NSMutableAttributedString alloc] initWithString:@""];
//    [centerText setAttributes:@{
//                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:13.f],
//                                NSParagraphStyleAttributeName: paragraphStyle
//                                } range:NSMakeRange(0, centerText.length)];
//    [centerText addAttributes:@{
//                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-Light" size:11.f],
//                                NSForegroundColorAttributeName: UIColor.grayColor
//                                } range:NSMakeRange(10, centerText.length - 10)];
//    [centerText addAttributes:@{
//                                NSFontAttributeName: [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:11.f],
//                                NSForegroundColorAttributeName: [UIColor colorWithRed:51/255.f green:181/255.f blue:229/255.f alpha:1.f]
//                                } range:NSMakeRange(centerText.length - 19, 19)];
//    chartView.centerAttributedText = centerText;
    
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

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    NSDictionary *nowDict = dict;
    NSArray *array = [dict allKeys];
//    NSMutableArray *entries = [[NSMutableArray alloc] init];
    BOOL hasData = false;
    
    NSArray *colors = @[[UIColor colorWithRed:72/255.0 green:218/255.0 blue:255/255.0 alpha:1],[UIColor colorWithRed:255/255.0 green:207/255.0 blue:72/255.0 alpha:1],[UIColor colorWithRed:95/255.0 green:220/255.0 blue:92/255.0 alpha:1] ,[UIColor colorWithRed:72/255.0 green:149/255.0 blue:255/255.0 alpha:1]];
    NSMutableArray *datas = [NSMutableArray new];
    
    for (int i = 0; i < array.count; i++)
    {
        NSString *key = [array objectAtIndex:i];
        double value = [nowDict safeDoubleForKey:key];
        if (value>0) {
            hasData = true;
        }
    }
    for (int i = 0; i < array.count; i++)
    {
        NSString *key = [array objectAtIndex:i];
        double value = [nowDict safeDoubleForKey:key];
        NSString *label = [key isEqualToString:@"group_earnings"]?@"团队流水":[key isEqualToString:@"other_earnings"]?@"其他":[key isEqualToString:@"personal_activation"]?@"个人激活":[key isEqualToString:@"personal_earnings"]?@"个人流水":[key isEqualToString:@"group_trading"]?@"团队流水":[key isEqualToString:@"personal_trading"]?@"个人流水":[key isEqualToString:@"group_activation"]?@"团队激活量":[key isEqualToString:@"personal_activation"]?@"个人激活量":@"";
//        [entries addObject:[[PieChartDataEntry alloc] initWithValue:value label:label]];
        if (!hasData) {
            JXCircleModel *model = [[JXCircleModel alloc]init];
            model.color = colors[i];
            model.textcolor = [UIColor blackColor];
            model.number = [NSString stringWithFormat:@"%@",@"250"];
            model.name = label;
            [datas  addObject:model];
        }
        else
        {
            JXCircleModel *model = [[JXCircleModel alloc]init];
            model.color = colors[i];
            model.textcolor = [UIColor blackColor];
            model.number = [NSString stringWithFormat:@"%.2f",value];
            model.name = label;
            [datas  addObject:model];
        }
    }
    [self.circleRatioView removeFromSuperview];
    self.circleRatioView = nil;
    self.circleRatioView = [[JXCircleRatioView alloc]initWithFrame:CGRectMake((ScreenWidth-180)/2,20,180,180)  andDataArray:datas CircleRadius:59];
    self.circleRatioView.bgColor = [UIColor whiteColor];
    self.circleRatioView.outRadius = 20;
    self.circleRatioView.backgroundColor = [UIColor whiteColor];
    [self.pieChartView addSubview:self.circleRatioView];

//    PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:entries label:@""];
//    dataSet.sliceSpace = 2.0;
//    NSMutableArray *colors = [[NSMutableArray alloc] init];
//    [colors addObject:RGB(253, 210, 88)];
//    [colors addObject:RGB(33, 115, 243)];
//    [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//    dataSet.colors = colors;
//    dataSet.valueLinePart1OffsetPercentage = 0.8;
//    dataSet.valueLinePart1Length = 0.2;
//    dataSet.valueLinePart2Length = 0.4;
//    dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
//    PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
//    [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
//    [data setValueTextColor:UIColor.blackColor];
//    if (hasData) {
//        _pieChartView.data = data;
//    }
}

-(void)setLabel:(NSString *)label
{
    _label = label;
    self.price.text = [NSString stringWithFormat:@"%@",label];
}
@end
