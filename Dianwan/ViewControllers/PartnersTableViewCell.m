//
//  PartnersTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "PartnersTableViewCell.h"
@interface PartnersTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *acoverImageview;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phonrNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countNumLabel;

@end

@implementation PartnersTableViewCell

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
    
    [self.acoverImageview sd_setImageWithURL:[NSURL URLWithString:[_dict safeStringForKey:@"member_avatar"]]];
    self.nameLabel.text = [_dict safeStringForKey:@"truename"];
    self.phonrNumLabel.text = [_dict safeStringForKey:@"member_mobile"];
    self.countNumLabel.text =[NSString stringWithFormat:@"累计:%@",[_dict safeStringForKey:@"total_price"]];
    self.timeLabel.text = [_dict safeStringForKey:@"created_date"];
    
}

@end
