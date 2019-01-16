//
//  WithdrawalTableViewCell.m
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "WithdrawalTableViewCell.h"

@implementation WithdrawalTableViewCell

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
    
    self.monryCountLabel.text =[_dict safeStringForKey:@"pdc_amount"];
    
    self.titleLabel.text = [_dict safeStringForKey:@"pdc_payment_state"];
    
    self.withdRawalTimeLabel.text = [_dict safeStringForKey:@"pdc_addtime"];
    
    self.arriveTimeLabel.text = [_dict safeStringForKey:@"pdc_expect_time"];
    
    self.noteLabel.text = [_dict safeStringForKey:@"pdc_amount"];
    
    self.bankNameLabel.text = [_dict safeStringForKey:@"pdc_bank_name"];
}

@end
