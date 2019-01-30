//
//  FirstHeaderView.m
//  DotaSell
//
//  Created by 黄哲麟 on 2017/7/6.
//  Copyright © 2017年 intexh. All rights reserved.
//

#import "FirstHeaderView.h"

@implementation FirstHeaderView

-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = RGB(253, 210, 88);
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, 100, 30)];
        self.label.font = [UIFont systemFontOfSize:14];
        self.label.textColor = [UIColor darkGrayColor];
        [self addSubview:self.label];
    }
    return self;
}
@end
