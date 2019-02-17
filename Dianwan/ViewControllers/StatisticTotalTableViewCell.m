//
//  StatisticTotalTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/29.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "StatisticTotalTableViewCell.h"

@implementation StatisticTotalTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
//    [self setupPieChartView:self.chartView];
//    [self setupPieChartView:self.chartView2];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setPath:(NSIndexPath *)path
{
    _path = path;
    if (path.row==0) {
//        self.name.text = @"交易量";
        self.img.image = [UIImage imageNamed:@"交易量"];
        self.chartLb.text = @"今日交易量";
        self.chartLb2.text = @"总交易量";
    }
    if (path.row==1) {
//        self.name.text = @"激活量";
        self.img.image = [UIImage imageNamed:@"激活量"];
        self.chartLb.text = @"今日激活量";
        self.chartLb2.text = @"总激活量";
    }
    if (path.row==2) {
//        self.name.text = @"总收益";
        self.img.image = [UIImage imageNamed:@"总收益"];
        self.chartLb.text = @"今日收益";
        self.chartLb2.text = @"总收益";
    }
    
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM-dd";
    NSString *search_date_star =[dateFormatter stringFromDate:[NSDate date]];
    NSString *search_date_end =[dateFormatter stringFromDate:[NSDate date]];
    if (search_date_star) {
        [param setValue:search_date_star forKey:@"search_date_star"];
    }
    if (search_date_end) {
        [param setValue:search_date_end forKey:@"search_date_end"];
    }
    [param setValue:@(self.path.row+1) forKey:@"type"];
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Statistics/my_stats" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            NSDictionary *nowDict = [[data safeDictionaryForKey:@"result"] safeDictionaryForKey:@"present"];
            if (nowDict) {
                NSArray *array = [nowDict allKeys];
//                NSMutableArray *entries = [[NSMutableArray alloc] init];
             
                NSArray *colors = @[[UIColor colorWithRed:255/255.0 green:207/255.0 blue:72/255.0 alpha:1],[UIColor colorWithRed:72/255.0 green:218/255.0 blue:255/255.0 alpha:1]];
                NSMutableArray *datas = [NSMutableArray new];
                
                double all = 0;
                BOOL hasData = false;
                for (int i = 0; i < array.count; i++)
                {
                    NSString *key = [array objectAtIndex:i];
                    double value = [nowDict safeDoubleForKey:key];
                    if (i==1) {
                        if (path.row==0) {
                            self.person1.text = [NSString stringWithFormat:@"商户:￥%.2f",value];
                        }
                        if (path.row==1) {
                            self.person1.text = [NSString stringWithFormat:@"商户:%d台",(int)value];
                        }
                        if (path.row==2) {
                            self.person1.text = [NSString stringWithFormat:@"商户:￥%.2f",value];
                        }
                    }
                    else if (i==0) {
                        if (path.row==0) {
                            self.team1.text = [NSString stringWithFormat:@"渠道:￥%.2f",value];
                        }
                        if (path.row==1) {
                            self.team1.text = [NSString stringWithFormat:@"渠道:%d台",(int)value];
                        }
                        if (path.row==2) {
                            self.team1.text = [NSString stringWithFormat:@"渠道:￥%.2f",value];
                        }
                    }
                    if (value>0) {
                        hasData = true;
                        all += value;
                    }
                }
                if (path.row==0) {
                    self.total.text = [NSString stringWithFormat:@"￥%.2f",all];
                }
                if (path.row==1) {
                    self.total.text = [NSString stringWithFormat:@"%d台",(int)all];
                }
                if (path.row==2) {
                    self.total.text = [NSString stringWithFormat:@"￥%.2f",all];
                }
                
                for (int i = 0; i < array.count; i++)
                {
                    NSString *key = [array objectAtIndex:i];
                    double value = [nowDict safeDoubleForKey:key];
                    NSString *label = [key isEqualToString:@"groups"]?@"渠道":[key isEqualToString:@"personals"]?@"商户":@"";
//                    if (value>0) {
//                        [entries addObject:[[PieChartDataEntry alloc] initWithValue:value label:label]];
//                    }
//                    if (value>0) {
//                        hasData = true;
//                    }
                    if (!hasData) {
                        JXCircleModel *model = [[JXCircleModel alloc]init];
                        model.color = colors[i];
//                        model.textcolor = [UIColor blackColor];
                        model.number = [NSString stringWithFormat:@"%@",@"250"];
//                        model.name = label;
                        [datas  addObject:model];
                    }
                    else
                    {
                        JXCircleModel *model = [[JXCircleModel alloc]init];
                        model.color = colors[i];
//                        model.textcolor = [UIColor blackColor];
                        model.number = [NSString stringWithFormat:@"%.2f",value];
//                        model.name = label;
                        [datas  addObject:model];
                    }
                }
    
                [self.circleRatioView removeFromSuperview];
                self.circleRatioView = nil;
                    self.circleRatioView = [[JXCircleRatioView alloc]initWithFrame:CGRectMake((ScreenWidth/2-150)/2,0,150,145)  andDataArray:datas CircleRadius:10];
                self.circleRatioView.whiteRadius = 25;
                    self.circleRatioView.bgColor = [UIColor whiteColor];
                    self.circleRatioView.outRadius = 20;
                    self.circleRatioView.backgroundColor = [UIColor whiteColor];
                    [self.chartView addSubview:self.circleRatioView];

//                PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:entries label:@""];
//                dataSet.sliceSpace = 2.0;
//                NSMutableArray *colors = [[NSMutableArray alloc] init];
//                [colors addObject:RGB(253, 210, 88)];
//                [colors addObject:RGB(33, 115, 243)];
//                [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//                dataSet.colors = colors;
//                dataSet.valueLinePart1OffsetPercentage = 0.8;
//                dataSet.valueLinePart1Length = 0.2;
//                dataSet.valueLinePart2Length = 0.4;
//                dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
//                PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
//                [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
//                [data setValueTextColor:UIColor.blackColor];
//                if (hasData) {
//                self.chartView.data = data;
//                }
            }
            NSDictionary *totalDict = [[data safeDictionaryForKey:@"result"] safeDictionaryForKey:@"total"];
            if (totalDict) {
                NSArray *array = [totalDict allKeys];
//                NSMutableArray *entries = [[NSMutableArray alloc] init];
                
                NSArray *colors = @[[UIColor colorWithRed:72/255.0 green:218/255.0 blue:255/255.0 alpha:1],[UIColor colorWithRed:255/255.0 green:207/255.0 blue:72/255.0 alpha:1]];
                NSMutableArray *datas = [NSMutableArray new];
                
                double all = 0;
                BOOL hasData = false;
                for (int i = 0; i < array.count; i++)
                {
                    NSString *key = [array objectAtIndex:i];
                    double value = [totalDict safeDoubleForKey:key];
                    if (i==0) {
                        if (path.row==0) {
                            self.person2.text = [NSString stringWithFormat:@"商户:￥%.2f",value];
                        }
                        if (path.row==1) {
                            self.person2.text = [NSString stringWithFormat:@"商户:%d台",(int)value];
                        }
                        if (path.row==2) {
                            self.person2.text = [NSString stringWithFormat:@"商户:￥%.2f",value];
                        }
                    }
                    else if (i==1) {
                        if (path.row==0) {
                            self.team2.text = [NSString stringWithFormat:@"渠道:￥%.2f",value];
                        }
                        if (path.row==1) {
                            self.team2.text = [NSString stringWithFormat:@"渠道:%d台",(int)value];
                        }
                        if (path.row==2) {
                            self.team2.text = [NSString stringWithFormat:@"渠道:￥%.2f",value];
                        }
                    }
                    if (value>0) {
                        hasData = true;
                        all += value;
                    }
                }
                if (path.row==0) {
                    self.total2.text = [NSString stringWithFormat:@"￥%.2f",all];
                }
                if (path.row==1) {
                    self.total2.text = [NSString stringWithFormat:@"%d台",(int)all];
                }
                if (path.row==2) {
                    self.total2.text = [NSString stringWithFormat:@"￥%.2f",all];
                }
                
                for (int i = 0; i < array.count; i++)
                {
                    NSString *key = [array objectAtIndex:i];
                    double value = [(totalDict) safeDoubleForKey:key];
                    NSString *label = [key isEqualToString:@"group_total"]?@"商户":[key isEqualToString:@"personal_total"]?@"渠道":@"";
                    if (!hasData) {
                        JXCircleModel *model = [[JXCircleModel alloc]init];
                        model.color = colors[i];
//                        model.textcolor = [UIColor blackColor];
                        model.number = [NSString stringWithFormat:@"%@",@"250"];
//                        model.name = label;
                        [datas  addObject:model];
                    }
                    else
                    {
                        JXCircleModel *model = [[JXCircleModel alloc]init];
                        model.color = colors[i];
//                        model.textcolor = [UIColor blackColor];
                        model.number = [NSString stringWithFormat:@"%.2f",value];
//                        model.name = label;
                        [datas  addObject:model];
                    }
                }
                
                [self.circleRatioView2 removeFromSuperview];
                self.circleRatioView2 = nil;
                    self.circleRatioView2 = [[JXCircleRatioView alloc]initWithFrame:CGRectMake((ScreenWidth/2-150)/2,0,150,145)  andDataArray:datas CircleRadius:10];
                self.circleRatioView2.whiteRadius = 25;
                    self.circleRatioView2.bgColor = [UIColor whiteColor];
                    self.circleRatioView2.outRadius = 20;
                    self.circleRatioView2.backgroundColor = [UIColor whiteColor];
                    [self.chartView2 addSubview:self.circleRatioView2];

//                PieChartDataSet *dataSet = [[PieChartDataSet alloc] initWithValues:entries label:@""];
//                dataSet.sliceSpace = 2.0;
//                NSMutableArray *colors = [[NSMutableArray alloc] init];
//                [colors addObject:RGB(253, 210, 88)];
//                [colors addObject:RGB(33, 115, 243)];
//                [colors addObjectsFromArray:ChartColorTemplates.vordiplom];
//                dataSet.colors = colors;
//                dataSet.valueLinePart1OffsetPercentage = 0.8;
//                dataSet.valueLinePart1Length = 0.2;
//                dataSet.valueLinePart2Length = 0.4;
//                dataSet.yValuePosition = PieChartValuePositionOutsideSlice;
//                PieChartData *data = [[PieChartData alloc] initWithDataSet:dataSet];
//                [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:13.f]];
//                [data setValueTextColor:UIColor.blackColor];
//                if (hasData) {
//                self.chartView2.data = data;
//                }
            }
        }
    }];
}

- (IBAction)showMoreAct:(UIButton *)sender {
    [self.delegate showMoreInfoForCell:self.path];
}
@end
