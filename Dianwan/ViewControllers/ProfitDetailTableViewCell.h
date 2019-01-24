//
//  ProfitDetailTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/24.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProfitDetailTableViewCell : UITableViewCell
@property (strong,nonatomic) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *time;
@end

NS_ASSUME_NONNULL_END
