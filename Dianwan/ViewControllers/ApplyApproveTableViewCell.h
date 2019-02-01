//
//  ApplyApproveTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/1.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplyApproveTableViewCell : UITableViewCell
@property (strong,nonatomic) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UILabel *status;
@end

NS_ASSUME_NONNULL_END
