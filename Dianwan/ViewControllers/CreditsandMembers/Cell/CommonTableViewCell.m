//
//  CommonTableViewCell.m
//  Dianwan
//
//  Created by Yang on 2019/1/20.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "CommonTableViewCell.h"
@interface CommonTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *statuesLabel;

@end

@implementation CommonTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict ;
    self.statuesLabel.text  = [_dict safeStringForKey:@"stagetext"];
    self.countLabel.text =[NSString stringWithFormat:@"+%@", [_dict safeNumberForKey:@"pl_points"]];
    self.timeLabel.text = [_dict safeStringForKey:@"addtimetext"];
}

@end
