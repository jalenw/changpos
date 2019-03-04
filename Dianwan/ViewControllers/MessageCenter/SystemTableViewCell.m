//
//  SystemTableViewCell.m
//  Dianwan
//
//  Created by Yang on 2019/1/23.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "SystemTableViewCell.h"

@implementation SystemTableViewCell

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
    self.titleLabel.text = [_dict safeStringForKey:@"push_title"];
    self.contentLabel.text = [_dict safeStringForKey:@"push_message"];
    self.timeLabel.text = [_dict safeStringForKey:@"push_time"];
    self.contentLabel.height = [Tooles calculateTextHeight:ScreenWidth-64 Content:[dict safeStringForKey:@"push_message"] fontSize:17]>145?145:[Tooles calculateTextHeight:ScreenWidth-64 Content:[dict safeStringForKey:@"push_message"] fontSize:17];
}

+(CGFloat)heightForSystemTableViewCell:(NSDictionary *)dict
{
    CGFloat height = 45+23;
    height += [Tooles calculateTextHeight:ScreenWidth-64 Content:[dict safeStringForKey:@"push_message"] fontSize:17]>145?145:[Tooles calculateTextHeight:ScreenWidth-64 Content:[dict safeStringForKey:@"push_message"] fontSize:17];
    return height;
}
@end
