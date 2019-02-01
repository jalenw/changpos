//
//  TransfresTableViewCell.m
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "TransfresTableViewCell.h"

@implementation TransfresTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    self.transferserLabel.text =[_dict safeStringForKey:@"member_Initiator"];
    self.receivingerLabel.text=[_dict safeStringForKey:@"recipient_name"];
    self.phoneNumLabel.text =[_dict safeStringForKey:@"recipient_mobile"];
    self.typeStateLabel.text=[_dict safeIntForKey:@"is_type"]==1?@"已付款":@"未付款";
    self.timeLabel.text =[_dict safeStringForKey:@"equipment_time"];
}

@end
