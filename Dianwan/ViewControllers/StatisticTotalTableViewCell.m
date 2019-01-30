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
    [self setupPieChartView:self.chartView];
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
        self.name.text = @"交易量";
    }
    if (path.row==1) {
        self.name.text = @"激活量";
    }
    if (path.row==2) {
        self.name.text = @"总收益";
    }
}

- (IBAction)showMoreAct:(UIButton *)sender {
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
    [[ServiceForUser manager]postMethodName:@"mobile/Statistics/my_stats" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            
        }
    }];
    [self.delegate showMoreInfoForCell:self.path];
}
@end
