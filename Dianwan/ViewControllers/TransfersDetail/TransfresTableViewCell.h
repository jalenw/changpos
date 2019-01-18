//
//  TransfresTableViewCell.h
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransfresTableViewCell : UITableViewCell
@property (nonatomic,strong)NSDictionary *dict;
//调拨者
@property (weak, nonatomic) IBOutlet UILabel *transferserLabel;
@property (weak, nonatomic) IBOutlet UILabel *receivingerLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeStateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

NS_ASSUME_NONNULL_END
