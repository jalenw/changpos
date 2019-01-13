//
//  CardInfoModel.h
//  BaseProject
//
//  Created by Mac on 2018/11/1.
//  Copyright © 2018年 ZNH. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface CardInfoModel : NSObject

@property(nonatomic,strong)NSNumber *status;
@property(nonatomic,strong)NSNumber *card_id;
@property(nonatomic,copy)NSString *bank_img;
@property(nonatomic,copy)NSString *user_name;
@property(nonatomic,copy)NSString *bank_name;
@property(nonatomic,copy)NSString *bank_card;
@end
