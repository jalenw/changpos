//
//  SystemTableViewCell.h
//  Dianwan
//
//  Created by Yang on 2019/1/23.
//  Copyright © 2019 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface SystemTableViewCell : BaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property(nonatomic,strong)NSDictionary *dict;

@end

NS_ASSUME_NONNULL_END
