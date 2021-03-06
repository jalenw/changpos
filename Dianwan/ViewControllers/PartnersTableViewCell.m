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
@property (weak, nonatomic) IBOutlet UILabel *allcountLabel;

@end

@implementation PartnersTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgView.borderColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"rectangle_bg"]];
    self.nameLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];
    self.phonrNumLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];
    self.countNumLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];
    self.allcountLabel.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"btt_1"]];
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
    [attribut1 addAttribute:NSForegroundColorAttributeName
                      value:[UIColor whiteColor]
                      range:NSMakeRange(pointRange1.location+pointRange1.length,1)];
    self.h9Label.attributedText =attribut1;
    
    NSMutableAttributedString *attribut2 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%d/%d",[dataarr[1] safeIntForKey:@"activation"],[dataarr[1] safeIntForKey:@"total_stock"]]]];
    NSRange pointRange2 = NSMakeRange(0, [NSString stringWithFormat:@"%d",[dataarr[1] safeIntForKey:@"activation"]].length);
    [attribut2 addAttribute:NSForegroundColorAttributeName
                      value:[UIColor greenColor]
                      range:pointRange2];
    [attribut2 addAttribute:NSForegroundColorAttributeName
                      value:[UIColor whiteColor]
                      range:NSMakeRange(pointRange2.location+pointRange2.length,1)];
    self.mp70Label.attributedText =attribut2;
    
      NSMutableAttributedString *attribut3 = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%d/%d",[dataarr[2] safeIntForKey:@"activation"],[dataarr[2] safeIntForKey:@"total_stock"]]];
     NSRange pointRange3 = NSMakeRange(0, [NSString stringWithFormat:@"%d",[dataarr[2] safeIntForKey:@"activation"]].length);
    [attribut3 addAttribute:NSForegroundColorAttributeName
                      value:[UIColor greenColor]
                      range:pointRange3];
    [attribut3 addAttribute:NSForegroundColorAttributeName
                      value:[UIColor whiteColor]
                      range:NSMakeRange(pointRange3.location+pointRange3.length,1)];
    self.zibeijiLabel.attributedText =attribut3;
    
    
    [self.acoverImageview sd_setImageWithURL:[NSURL URLWithString:[_dict safeStringForKey:@"member_avatar"]] placeholderImage:[UIImage imageNamed:@"default_user"]];
    self.nameLabel.text = [_dict safeStringForKey:@"truename"];
   
    self.phonrNumLabel.text = [_dict safeStringForKey:@"member_mobile"];

    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计:¥%@",[_dict safeStringForKey:@"total_price"]]];
    NSRange range = [[NSString stringWithFormat:@"累计:%@",[_dict safeStringForKey:@"total_price"]] rangeOfString:@":"];
    NSRange pointRange = NSMakeRange(0, range.location+1);
    [attribut addAttribute:NSForegroundColorAttributeName
                         value:[UIColor whiteColor]
                         range:pointRange];
   
    self.countNumLabel.attributedText =attribut;
    self.timeLabel.text = [_dict safeStringForKey:@"created_date"];
    self.allcountLabel.text = [NSString stringWithFormat:@"总交易量:¥%@",[_dict safeStringForKey:@"total_price"]];
    
    
}

@end
