//
//  RunningWaterTableViewCell.m
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "RunningWaterTableViewCell.h"

@implementation RunningWaterTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setDict:(NSDictionary *)dict{
    _dict =dict;
    self.phoneLabel.text = [_dict safeStringForKey:@"lg_member_name"];
    self.countLabel.text =[NSString stringWithFormat:@"%@",[_dict safeStringForKey:@"amount"]];
    self.numLabel.text =[NSString stringWithFormat:@"%d",[_dict safeIntForKey:@"rownum"]];
    [self.levelImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"会员%d",[_dict safeIntForKey:@"level"]]]];
   
}

@end
