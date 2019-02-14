//
//  JXCircleRatioView.m
//  circleViewDome
//
//  Created by mac on 17/4/13.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import "JXCircleRatioView.h"
#import "JXCircleModel.h"
#import "UIView+EasyLayout.h"
/*! 白色圆的半径 */
static CGFloat const whiteCircleRadius = 35.0;
/*! 指引线的小圆 */
static CGFloat const smallCircleRadius = 2.0;
/*! 指引线的文字字体大小 */
static CGFloat const nameTextFont = 16.0;
/*! 指引线的宽度 */
static CGFloat const lineWidth = 60.0;
/*! 折线的宽度 */
static CGFloat const foldLineWidth = 20.0;
#define degreesToRadian(x) ( 180.0 / PI * (x))


@implementation JXCircleRatioView

- (instancetype)initWithFrame:(CGRect)frame andDataArray:(NSMutableArray *)dataArray CircleRadius:(CGFloat)circleRadius{
    
    if (self = [super initWithFrame:frame]) {
        
        self.dataArray = dataArray;
        self.circleRadius = circleRadius;
    }
    return self;
}

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
    
    // 5.弧度的中心角度
    CGFloat h;// = (angle_end + angle_start) / 2.0;
    if (n==0) {
        h= 0.78539818525314331;
    }else if(n==1){
        h= 2.3561944961547852;
    }else if(n==2){
        h=  3.9269909858703613;
    }else{
        h=  5.4977874755859375;
    }
    
    // 6.小圆的中心点
    //    self.frame.size.height / 2
    CGFloat xx = self.frame.size.width / 2 + (_circleRadius +35) * cos(h);
    CGFloat yy = (160 +20) + (_circleRadius-10 ) * sin(h);
    
    // 7.画折线
    [self addLineAndnumber:color andCGContextRef:ctx andX:xx andY:yy andInt:n angele:h];
}

/**
 * @color 颜色
 * @ctx CGContextRef
 * @x 小圆的中心点的x
 * @y 小圆的中心点的y
 * @n 表示第几个弧行
 * @angele 弧度的中心角度
 */

//画线
-(void)addLineAndnumber:(UIColor *)color
        andCGContextRef:(CGContextRef)ctx
                   andX:(CGFloat)x
                   andY:(CGFloat)y
                 andInt:(int)n
                 angele:(CGFloat)angele{
    
    // 1.小圆的圆心
    CGFloat smallCircleCenterPointX = x;
    CGFloat smallCircleCenterPointY = y;
    
    
    // 2.折点
    CGFloat lineLosePointX = 0.0 ; //指引线的折点
    CGFloat lineLosePointY = 0.0 ; //
    
    // 3.指引线的终点
    CGFloat lineEndPointX ; //
    CGFloat lineEndPointY ; //
    
    // 4.数字的起点
    CGFloat numberStartX;
    CGFloat numberStartY;
    
    // 5.文字的起点
    CGFloat textStartX;
    CGFloat textStartY;
    
    // 6.数字的长度
    JXCircleModel *model = self.dataArray[n];
    NSString *number = model.number;
    
    CGSize numberSize = [number sizeWithAttributes:@{
                                                     NSFontAttributeName:[UIFont systemFontOfSize:16.0]
                                                     }];
    
    // 文字size
    CGSize textSize = [model.name sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:nameTextFont]}];
    
    
    
    // 设置折点
    lineLosePointX = smallCircleCenterPointX + foldLineWidth * cos(angele);
    lineLosePointY = smallCircleCenterPointY + foldLineWidth * sin(angele);
    
    
    // 7.画小圆
    if (smallCircleCenterPointX > self.bounds.size.width * 0.5) {
        
        // 指引线终点
        lineEndPointX = lineLosePointX + lineWidth;
        lineEndPointY = lineLosePointY;
        
        // 数字
        numberStartX = lineEndPointX - numberSize.width;
        numberStartY = lineEndPointY - numberSize.height;
        
        
        
        // 文字
        textStartX = lineEndPointX - textSize.width;
        textStartY = lineEndPointY;
        
        
        
    }else{
        
        // 指引线终点
        lineEndPointX = lineLosePointX - lineWidth;
        lineEndPointY = lineLosePointY;
        
        // 数字
        numberStartX = lineEndPointX;
        numberStartY = lineEndPointY - numberSize.height;
        
        // 文字
        textStartX = lineEndPointX;
        textStartY = lineEndPointY;
        
    }
    
    // 8.画小圆
    /*!创建圆弧
     参数：
     center->圆点
     radius->半径
     startAngle->起始位置
     endAngle->结束为止
     clockwise->是否顺时针方向
     */
    
    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(smallCircleCenterPointX, smallCircleCenterPointY) radius:smallCircleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [color set];
    // 填充
    [arcPath fill];
    // 描边，路径创建需要描边才能显示出来
    [arcPath stroke];
    
    
    
    
    UIBezierPath *arcPath1 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(lineLosePointX, lineLosePointY) radius:smallCircleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [color set];
    // 填充
    [arcPath1 fill];
    // 描边，路径创建需要描边才能显示出来
    [arcPath1 stroke];
    
    UIBezierPath *arcPath2 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(lineLosePointX, lineLosePointY) radius:smallCircleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [color set];
    // 填充
    [arcPath2 fill];
    // 描边，路径创建需要描边才能显示出来
    [arcPath2 stroke];
    
    UIBezierPath *arcPath3 = [UIBezierPath bezierPathWithArcCenter:CGPointMake(lineEndPointX, lineEndPointY) radius:smallCircleRadius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    
    [color set];
    // 填充
    [arcPath3 fill];
    // 描边，路径创建需要描边才能显示出来
    [arcPath3 stroke];
    
    
    
    // 9.画指引线
    CGContextBeginPath(ctx);
    
    CGContextMoveToPoint(ctx, smallCircleCenterPointX, smallCircleCenterPointY);
    CGContextAddLineToPoint(ctx, lineLosePointX, lineLosePointY);
    
    CGContextAddLineToPoint(ctx, lineEndPointX, lineEndPointY);
    CGContextSetLineWidth(ctx, 1);
    
    
    //填充颜色
    CGContextSetFillColorWithColor(ctx , color.CGColor);
    CGContextStrokePath(ctx);
    
    // 10.画指引线上的数字
    if([model.number isEqualToString: @"250"]){
        model.number=@"0.00";
    }
    
    UILabel *numberLabel;
    if(n==2){
        numberLabel =  [[UILabel alloc]initWithFrame:CGRectMake(numberStartX+numberSize.width/2-7, numberStartY, numberSize.width+5, numberSize.height)];
    }else if(n==1){
        numberLabel  =  [[UILabel alloc]initWithFrame:CGRectMake(numberStartX+numberSize.width/2, numberStartY, numberSize.width+5, numberSize.height)];
    }else if(n==0){
        numberLabel  =  [[UILabel alloc]initWithFrame:CGRectMake(numberStartX-numberSize.width/2, numberStartY, numberSize.width+5, numberSize.height)];
    }else if(n==3){
        numberLabel  =  [[UILabel alloc]initWithFrame:CGRectMake(numberStartX-numberSize.width/2, numberStartY, numberSize.width+5, numberSize.height)];
    }
    [numberLabel setText:model.number];
    numberLabel.textColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1];
    numberLabel.textAlignment=NSTextAlignmentCenter;
    numberLabel.font = [UIFont systemFontOfSize:16.0];
    [self addSubview:numberLabel];
    //     [model.number drawAtPoint:CGPointMake(numberStartX, numberStartY) withAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0],NSForegroundColorAttributeName:color}];
    
    // 11.画指引线下的文字
    // 11.1设置段落风格
    NSMutableParagraphStyle * paragraph = [[NSMutableParagraphStyle alloc]init];
    paragraph.alignment = NSTextAlignmentCenter;
    
    if (lineEndPointX < [UIScreen mainScreen].bounds.size.width / 2.0) {
        paragraph.alignment = NSTextAlignmentCenter;
    }
    
    
    UILabel *wenziLabel;
    if(n==2){
        wenziLabel = [[UILabel alloc]initWithFrame:CGRectMake(textStartX, textStartY, textSize.width, textSize.height)];
    }else if(n==1){
        wenziLabel  =  [[UILabel alloc]initWithFrame:CGRectMake(textStartX, textStartY, textSize.width, textSize.height)];
    }else if(n==0){
        wenziLabel  =  [[UILabel alloc]initWithFrame:CGRectMake(textStartX, textStartY, textSize.width, textSize.height)];
    }else if(n==3){
        wenziLabel  =  [[UILabel alloc]initWithFrame:CGRectMake(textStartX, textStartY, textSize.width, textSize.height)];
    }
    
    wenziLabel.center =CGPointMake((lineLosePointX+lineEndPointX)/2, textStartY+(textSize.height+12)/2);
    wenziLabel.size =textSize;
    [wenziLabel setText:model.name];
    wenziLabel.textAlignment = NSTextAlignmentCenter;
    wenziLabel.textColor = [UIColor colorWithRed:85.0/255.0 green:85.0/255.0 blue:85.0/255.0 alpha:1];
    wenziLabel.font =[UIFont systemFontOfSize:12];
    [self addSubview:wenziLabel];
    
}

/// 重绘
- (void)setDataArray:(NSMutableArray *)dataArray{
    _dataArray = dataArray;
    [self setNeedsDisplay];
}

@end
