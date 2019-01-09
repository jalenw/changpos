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
    [self setupPieChartView:self.pieChartView];
}

- (void)setupPieChartView:(PieChartView *)chartView
{
    chartView.usePercentValuesEnabled = YES;
    chartView.drawSlicesUnderHoleEnabled = NO;
    chartView.holeRadiusPercent = 0.58;
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
    
    ChartLegend *l = chartView.legend;
    l.horizontalAlignment = ChartLegendHorizontalAlignmentRight;
    l.verticalAlignment = ChartLegendVerticalAlignmentTop;
    l.orientation = ChartLegendOrientationVertical;
    l.drawInside = NO;
    l.xEntrySpace = 7.0;
    l.yEntrySpace = 0.0;
    l.yOffset = 0.0;
}
@end
