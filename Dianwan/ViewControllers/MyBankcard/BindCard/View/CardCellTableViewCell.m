//
//  CardCellTableViewCell.m
//  BaseProject
//
//  Created by Mac on 2018/11/1.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "CardCellTableViewCell.h"
#import "CardInfoModel.h"
@interface CardCellTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *cardTypeImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardBanckLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;

@end

@implementation CardCellTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setModel:(CardInfoModel *)model{
    _model =model;
//    [self.cardTypeImageView sd_setImageWithURL:[NSURL URLWithString:_model.bank_img]];
    self.cardBanckLabel.text =_model.bank_name;
    NSString *cardNum = [_model.bank_card substringWithRange:NSMakeRange(_model.bank_card.length-4, 4)];
//rhgfogervf'j'o's'j'd
    
    NSString *bankCard = [NSString stringWithFormat:@"**** **** **** %@",cardNum];;
    
    self.cardNumberLabel.text =bankCard;
}

@end
