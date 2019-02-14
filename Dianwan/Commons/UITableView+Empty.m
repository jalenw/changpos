//
//  UITableView+Empty.m
//  Dianwan
//
//  Created by 黄哲麟 on 2018/8/3.
//  Copyright © 2018年 intexh. All rights reserved.
//

#import "UITableView+Empty.h"
#import <objc/runtime.h>
#import <objc/message.h>
static const char * code_key = "code_key";
@implementation UITableView (Empty)

- (void)setBgView:(UIImageView*)bgView{
    objc_setAssociatedObject(self, code_key, bgView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
}
- (UIImageView*)bgView{
    return (UIImageView*)objc_getAssociatedObject(self, code_key);
}


-(void)setEmptyView
{
    if (self.bgView==nil) {
        self.bgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 184, 184)];
        [self.bgView setImage:[UIImage imageNamed:@"bg_empty"]];
        self.bgView.contentMode = UIViewContentModeScaleAspectFit;
        self.bgView.backgroundColor = [UIColor clearColor];
        self.bgView.center = self.center;
        self.bgView.centerY = self.centerY-150;
    }
    [self addSubview:self.bgView];
}

-(void)removeEmptyView
{
    [self.bgView removeFromSuperview];
}
@end
