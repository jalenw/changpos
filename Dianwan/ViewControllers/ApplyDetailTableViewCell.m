//
//  ApplyDetailTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/11.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ApplyDetailTableViewCell.h"
@interface ApplyDetailTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *snNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *creatTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation ApplyDetailTableViewCell

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
    self.titleLabel.text = [_dict safeStringForKey:@"title"];
    self.creatTimeLabel.text = [[_dict safeStringForKey:@"create_time"] substringToIndex:[_dict safeStringForKey:@"create_time"].length-3 ];
    self.snNumLabel.text =[NSString stringWithFormat:@"%@ %@",[_dict safeStringForKey:@"member_name"],[_dict safeStringForKey:@"member_id"]];
    
    self.desc.text =[NSString stringWithFormat:@"%@ %@",[_dict safeStringForKey:@"goods_name"],[_dict safeStringForKey:@"goods_serial"]];
    
    switch ([[_dict safeStringForKey:@"examine_type"] integerValue]) {
        case 0:
            self.typeLabel.text = @"待上级审核 ";
            break;
        case 1:
            self.typeLabel.text = @"待平台审核 ";
            break;
        case 2:
            self.typeLabel.text = @"审核通过 ";
            break;
        case 3:
            self.typeLabel.text = @"审核失败 ";
            break;
        case 4:
            self.typeLabel.text = @"待下级审核 ";
            break;
        case 5:
            self.typeLabel.text = @"请审核 ";
            break;
    }
    
}
@end
