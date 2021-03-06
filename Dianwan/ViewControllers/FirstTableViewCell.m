//
//  FirstTableViewCell.m
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "FirstTableViewCell.h"

@implementation FirstTableViewCell

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
    self.numLabel.text =[NSString stringWithFormat:@"%@",[_dict safeIntForKey:@"rownum"]>999?@"999+":[_dict safeStringForKey:@"rownum"]];
    
    [self.levelImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"会员%d",[_dict safeIntForKey:@"level"]]]];
    
}

@end
