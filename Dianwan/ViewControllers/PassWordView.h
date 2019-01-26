//
//  PassWordView.h
//  BaseProject
//
//  Created by Mac on 2018/11/3.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SYPasswordView.h"

@interface PassWordView : UIView
@property (weak, nonatomic) IBOutlet UILabel *stringLabel;
@property(nonatomic,strong)SYPasswordView *pwInputView;
@end
