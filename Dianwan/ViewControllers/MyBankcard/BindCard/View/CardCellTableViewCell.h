//
//  CardCellTableViewCell.h
//  BaseProject
//
//  Created by Mac on 2018/11/1.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CardInfoModel;

@interface CardCellTableViewCell : BaseTableViewCell
@property(nonatomic,strong)CardInfoModel *model;

@end
