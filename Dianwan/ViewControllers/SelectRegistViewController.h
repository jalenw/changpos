//
//  SelectRegistViewController.h
//  BaseProject
//
//  Created by Mac on 2018/10/23.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "BaseViewController.h"

@interface SelectRegistViewController : BaseViewController
@property (copy, nonatomic) void(^resgiterSuccess)(NSString *phone,NSString *password);
@end
