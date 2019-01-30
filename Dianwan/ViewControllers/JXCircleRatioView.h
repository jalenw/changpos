//
//  JXCircleRatioView.h
//  circleViewDome
//
//  Created by mac on 17/4/13.
//  Copyright © 2017年 Mr.Gao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JXCircleRatioView : UIView

@property(nonatomic, strong) NSArray *dataArray; // 数据数组

- (void)updateDataArray:(NSArray *)dataArray;
@end
