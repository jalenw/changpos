//
//  RewardTableViewCell.m
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "RewardTableViewCell.h"

@implementation RewardTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setDict:(NSDictionary *)dict
{
    _dict =dict;
    self.typeLabel.text= [ _dict safeStringForKey:@"push_title"];
    self.messageLabel.text= [ _dict safeStringForKey:@"push_message"];
    self.timeLabel.text= [ _dict safeStringForKey:@"push_time"];
    
}
    
@end
