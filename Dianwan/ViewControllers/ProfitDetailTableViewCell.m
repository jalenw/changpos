//
//  ProfitDetailTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/24.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ProfitDetailTableViewCell.h"

@implementation ProfitDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    self.name.text = [dict safeStringForKey:@"lg_type"];
    if ([[dict safeStringForKey:@"lg_av_amount"] containsString:@"+"]) {
        self.price.textColor = [UIColor redColor];
    }
    else
    {
        self.price.textColor = [UIColor greenColor];
    }
    self.price.text = [dict safeStringForKey:@"lg_av_amount"];
    self.desc.text = [dict safeStringForKey:@"lg_desc"];
    self.desc.height = [Tooles calculateTextHeight:ScreenWidth-134-12 Content:self.desc.text fontSize:12];
    self.time.text = [dict safeStringForKey:@"lg_addtime"];
}

+(CGFloat)heightForProfitDetailTableViewCell:(NSDictionary *)dict
{
    NSString *text = [dict safeStringForKey:@"lg_desc"];
    CGFloat height = 64;
    height += [Tooles calculateTextHeight:ScreenWidth-134-12 Content:text fontSize:12];
    return height;
}
@end
