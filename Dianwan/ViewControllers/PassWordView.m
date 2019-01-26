//
//  PassWordView.m
//  BaseProject
//
//  Created by Mac on 2018/11/3.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "PassWordView.h"
#import "UIView+EasyLayout.h"
#import "SYPasswordView.h"
@interface PassWordView ()

@end

@implementation PassWordView


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.pwInputView = [[SYPasswordView alloc] initWithFrame:CGRectMake(14, _stringLabel.bottom+20, self.frame.size.width - 28, 45)];
        
        self.pwInputView.layer.cornerRadius = 5;
        self.pwInputView.layer.masksToBounds =YES;
        [self addSubview: self.pwInputView ];
       
        
    }
    return self;
}



@end
