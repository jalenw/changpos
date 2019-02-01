//
//  ToolTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/21.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ToolTableViewCell.h"

@implementation ToolTableViewCell

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
    self.name.text = [NSString stringWithFormat:@"%@ %@",[dict safeStringForKey:@"goods_name"],[dict safeStringForKey:@"goods_serial"]];
    self.snLb.text = [NSString stringWithFormat:@"SN号:%@",[dict safeStringForKey:@"sn_code"]];
    self.priceLb.text = [NSString stringWithFormat:@"￥%@",[dict safeStringForKey:@"goods_price"]];
    [self.img sd_setImageWithURL:[NSURL URLWithString: [dict safeStringForKey:@"goods_image"]]];
    if ([dict safeStringForKey:@"actication_time"].length>0) {
        self.timeLb.text = [NSString stringWithFormat:@"激活时间:%@",[dict safeStringForKey:@"actication_time"]];
    }
    else
    {
        self.timeLb.text = @"";
    }
}
@end
