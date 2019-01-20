//
//  ShowWithdrawaldetailsViewController.h
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ShowWithdrawaldetailsViewController : BaseViewController
@property(nonatomic,strong)NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *moneyCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *statueLabel;
@property (weak, nonatomic) IBOutlet UILabel *showMoneycountLabel;
@property (weak, nonatomic) IBOutlet UILabel *poundageLabel;
@property (weak, nonatomic) IBOutlet UILabel *createTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *arriveTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *bankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *idLabel;
@end

NS_ASSUME_NONNULL_END
