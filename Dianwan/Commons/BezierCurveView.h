//
//  BezierCurveView.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/14.
//  Copyright © 2019年 intexh. All rights reserved.
//

#define XYQColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]
#define XYQRandomColor XYQColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define MARGIN  30 // 坐标轴与画布间距
#define Y_EVERY_MARGIN 20 // y轴每一个值的间隔数

#import <UIKit/UIKit.h>
// 线条类型
typedef NS_ENUM(NSInteger, LineType) {
    LineType_Straight, // 折线
    LineType_Curve // 曲线
};
@interface BezierCurveView : UIView

//初始化画布
+(instancetype)initWithFrame:(CGRect)frame;
//画多根折线图
-(void)drawMoreLineChartViewWithX_Value_Names:(NSMutableArray *)x_names TargetValues:(NSMutableArray *)targetValues LineType:(LineType) lineType;
@end

