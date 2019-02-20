//
//  RewardTableViewCell.h
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface RewardTableViewCell : BaseTableViewCell
@property(nonatomic,strong)NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
