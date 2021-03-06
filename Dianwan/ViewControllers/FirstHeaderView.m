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
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"btt_1"]];
        img.frame = CGRectMake(0, 0, ScreenWidth, 40);
        [self addSubview:img];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 100, 30)];
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.textColor = [UIColor darkGrayColor];
        [self addSubview:self.label];
    }
    return self;
}
@end
