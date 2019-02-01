//
//  JXCircleRatioView.m
//  circleViewDome
//
//  Created by mac on 17/4/13.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXCircleRatioView.h"
#import "JXCircleModel.h"

/*! 白色圆的半径 */
static CGFloat const whiteCircleRadius = 25.0;

#define degreesToRadian(x) ( 180.0 / PI * (x))


@implementation JXCircleRatioView


/// 比例
- (CGFloat)getShareNumber:(NSArray *)arr{
    CGFloat f = 0.0;
    for (int  i = 0; i < arr.count; i++) {
        
        JXCircleModel *model = arr[i];
        f += [model.number floatValue];
    }
    //NSLog(@"总量：%.2f  比例:%.2f",f,360.0 / f);
    return M_PI*2 / f;
}

- (void)drawRect:(CGRect)rect {
    
    // 1.所占比例
    CGFloat bl = [self getShareNumber:self.dataArray];

  
    
    // 2.开启上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat angle_start = 0; //开始时的弧度  －－－－－ 旋转200度
    CGFloat ff = 0;  //记录偏转的角度 －－－－－ 旋转200度
    
    for (int i = 0; i < self.dataArray.count; i ++) {
        
        
        JXCircleModel *model = self.dataArray[i];
        
        CGFloat angle_end =  [model.number floatValue] * bl + ff;  //结束
        
        ff += [model.number floatValue] * bl;
        
        NSLog(@"angle_end == %f",angle_end);
        
        /*!参数：
         // 1.上下文
         // 2.中心点
         // 3.开始
         // 4.结束
         // 5.颜色
         */
        [self drawArcWithCGContextRef:ctx andWithPoint:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) andWithAngle_start:angle_start andWithAngle_end:angle_end andWithColor:model.color andInt:i];
        
        angle_start = angle_end;
    }
    //3.添加中心圆
    [self addCenterCircle];
    
}


/// 添加中心白色圆
-(void)addCenterCircle{
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2) radius:whiteCircleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [RGB(47, 29, 47) set];
    [arcPath fill];
    [arcPath stroke];
    
}



/**
 画圆弧
 
 @param ctx 上下文
 @param point 圆心
 @param angle_start 开始角度
 @param angle_end 结束角度
 @param color 颜色
 @param n 表示第几个弧行
 */
-(void)drawArcWithCGContextRef:(CGContextRef)ctx
                  andWithPoint:(CGPoint) point
            andWithAngle_start:(float)angle_start
              andWithAngle_end:(float)angle_end
                  andWithColor:(UIColor *)color
                        andInt:(int)n{
    
    // 1.开始画线
    CGContextMoveToPoint(ctx, point.x, point.y);

    // 2.颜色空间填充
    CGContextSetFillColor(ctx, CGColorGetComponents(color.CGColor));
    
    // 3.画圆
    CGContextAddArc(ctx, point.x, point.y, self.frame.size.width/2, angle_start, angle_end, 0);
    
    // 4.填充
    CGContextFillPath(ctx);
    
  
}

/// 重绘
- (void)updateDataArray:(NSArray *)dataArray{
    _dataArray = dataArray;
    [self setNeedsDisplay];
}


@end
