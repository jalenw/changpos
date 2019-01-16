//
//  WithdrawalTableViewCell.h
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WithdrawalTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *monryCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *withdRawalTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arriveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *noteLabel;
@property(nonatomic,strong)NSDictionary *dict;
@end

NS_ASSUME_NONNULL_END
