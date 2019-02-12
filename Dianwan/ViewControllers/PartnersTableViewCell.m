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
@property (weak, nonatomic) IBOutlet UILabel *h9Label;
@property (weak, nonatomic) IBOutlet UILabel *mp70Label;
@property (weak, nonatomic) IBOutlet UILabel *zibeijiLabel;

@end

@implementation PartnersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle_bg"]];
    self.nameLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];
    self.phonrNumLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];
    self.countNumLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDict:(NSDictionary *)dict{
    _dict = dict;
    NSArray *dataarr =[_dict safeArrayForKey:@"activation_info"];

    NSMutableAttributedString *attribut1 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%d/%d",[dataarr[0] safeIntForKey:@"activation"],[dataarr[0] safeIntForKey:@"total_stock"]]]];
    NSRange pointRange1 = NSMakeRange(0, [NSString stringWithFormat:@"%d",[dataarr[0] safeIntForKey:@"activation"]].length);
    [attribut1 addAttribute:NSForegroundColorAttributeName
                      value:[UIColor greenColor]
                      range:pointRange1];
    self.h9Label.attributedText =attribut1;
    
    NSMutableAttributedString *attribut2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%d/%d",[dataarr[1] safeIntForKey:@"activation"],[dataarr[1] safeIntForKey:@"total_stock"]]]];
    NSRange pointRange2 = NSMakeRange(0, [NSString stringWithFormat:@"%d",[dataarr[1] safeIntForKey:@"activation"]].length);
    [attribut2 addAttribute:NSForegroundColorAttributeName
                      value:[UIColor greenColor]
                      range:pointRange2];
    self.mp70Label.attributedText =attribut2;
//    self.mp70Label.text =[NSString stringWithFormat:@"%d/%d",[dataarr[1] safeIntForKey:@"activation"],[dataarr[1] safeIntForKey:@"total_stock"]] ;
    self.zibeijiLabel.text =[NSString stringWithFormat:@"%d/%d",[dataarr[2] safeIntForKey:@"activation"],[dataarr[2] safeIntForKey:@"total_stock"]] ;
    
    
    [self.acoverImageview sd_setImageWithURL:[NSURL URLWithString:[_dict safeStringForKey:@"member_avatar"]]];
    self.nameLabel.text = [_dict safeStringForKey:@"truename"];
   
    self.phonrNumLabel.text = [_dict safeStringForKey:@"member_mobile"];

    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计:¥%@",[_dict safeStringForKey:@"total_price"]]];
    NSRange range = [[NSString stringWithFormat:@"累计:%@",[_dict safeStringForKey:@"total_price"]] rangeOfString:@":"];
    NSRange pointRange = NSMakeRange(0, range.location+1);
    [attribut addAttribute:NSForegroundColorAttributeName
                         value:[UIColor whiteColor]
                         range:pointRange];
    
    self.countNumLabel.attributedText =attribut;//[NSString stringWithFormat:@"累计:%@",[_dict safeStringForKey:@"total_price"]];
    self.timeLabel.text = [_dict safeStringForKey:@"created_date"];
    
}

@end
