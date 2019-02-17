//
//  StoreTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/19.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "StoreTableViewCell.h"

@implementation StoreTableViewCell

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
    self.storeNameLb.text = [dict safeStringForKey:@"gc_name"];
    self.productNameLb.text = [dict safeStringForKey:@"goods_name"];
    self.seriesName.text = [dict safeStringForKey:@"goods_serial"];
    self.priceLb.text = [NSString stringWithFormat:@"¥%@元",[dict safeStringForKey:@"goods_price"]];
    self.totalLb.text = [NSString stringWithFormat:@"x%@",[dict safeStringForKey:@"goods_count_num"]];
    [self.img sd_setImageWithURL:[NSURL URLWithString: [dict safeStringForKey:@"goods_image"]]];
}

@end
