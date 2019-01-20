//
//  MerchantTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "MerchantTableViewCell.h"
@interface MerchantTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageview;
@property (weak, nonatomic) IBOutlet UILabel *snNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *countNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;


@end

@implementation MerchantTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDict:(NSDictionary *)dict
{
    _dict = dict;
    //开始绑定数据到UI
    self.timeLabel.text = [[_dict safeStringForKey:@"actication_time"] substringToIndex:[_dict safeStringForKey:@"actication_time"].length -8 ];
    self.nameLabel.text = [_dict safeStringForKey:@"goods_name"];
    self.snNumLabel.text =[NSString stringWithFormat:@"%@",[_dict safeStringForKey:@"sn_code"]];
    
    NSMutableAttributedString *attribut = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"累计 ¥%@",[_dict safeStringForKey:@"lg_av_amount"]]];
    //目的是想改变 ‘/’前面的字体的属性，所以找到目标的range
    NSRange range = [[NSString stringWithFormat:@"累计:%@",[_dict safeStringForKey:@"total_price"]] rangeOfString:@":"];
    NSRange pointRange = NSMakeRange(0, range.location+1);
    [attribut addAttribute:NSForegroundColorAttributeName
                     value:[UIColor whiteColor]
                     range:pointRange];
    
    self.countNumLabel.attributedText =attribut;
//    self.countNumLabel.text = [NSString stringWithFormat:@"累计:%@   ",[_dict safeStringForKey:@"lg_av_amount"]];
    
    
}
@end
