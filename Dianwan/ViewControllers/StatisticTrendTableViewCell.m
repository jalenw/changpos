//
//  StatisticTrendTableViewCell.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/29.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "StatisticTrendTableViewCell.h"

@implementation StatisticTrendTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showMoreAct:(UIButton *)sender {
    [self.delegate showMoreInfoForCell:self.path];
}
@end
