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
    self.countLabel.text = [_dict safeStringForKey:@"amount"];
    self.numLabel.text =[_dict safeStringForKey:@"rownum"];
    switch ([_dict safeIntForKey:@"level"]) {
        case 1:
             [self.levelImageView setImage:[UIImage imageNamed:@"byhy_1"]];
            break;
        case 2:
             [self.levelImageView setImage:[UIImage imageNamed:@"byhy_2"]];
            break;
        case 3:
             [self.levelImageView setImage:[UIImage imageNamed:@"byhy_3"]];
            break;
        }
   
}

@end