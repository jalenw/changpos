//
//  CardBindViewController.h
//  BaseProject
//
//  Created by Mac on 2018/10/23.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "BaseViewController.h"
#import "CardInfoModel.h"

@interface CardBindViewController : BaseViewController

@property(nonatomic,copy)void(^selectCardBlodk)(CardInfoModel  *model);

@property(nonatomic,assign)int typetag;

@end
