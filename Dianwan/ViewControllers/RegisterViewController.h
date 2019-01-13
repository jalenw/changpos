//
//  RegisterViewController.h
//  ZJDecoration
//
//  Created by ZNH on 2018/4/10.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "BaseViewController.h"

@interface RegisterViewController : BaseViewController

@property (copy, nonatomic) void(^resgiterSuccess)(NSString *phone,NSString *password);
-(instancetype)initWithCode:(NSString *)string;

@end
