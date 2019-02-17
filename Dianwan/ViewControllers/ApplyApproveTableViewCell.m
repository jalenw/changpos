//
//  ApplyApproveTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/1.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ApplyApproveTableViewCell.h"

@implementation ApplyApproveTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDict:(NSDictionary*)dict
{
    _dict = dict;
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ 调拨给 %@",[dict safeStringForKey:@"apply_member_name"],[dict safeStringForKey:@"member_name"]]];
    [str addAttribute:NSForegroundColorAttributeName
                          value:[UIColor lightGrayColor]
                          range:[[NSString stringWithFormat:@"%@ 调拨给 %@",[dict safeStringForKey:@"apply_member_name"],[dict safeStringForKey:@"member_name"]] rangeOfString:@"调拨给"]];
    self.name.attributedText = str;
    self.phone.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"member_mobile"]];
    self.status.text = [dict safeIntForKey:@"state"]==2?@"已拒绝":[dict safeIntForKey:@"state"]==1?@"已同意":@"待审核";
    self.time.text = [NSString stringWithFormat:@"%@",[dict safeStringForKey:@"created_time_date"]];
}
@end
