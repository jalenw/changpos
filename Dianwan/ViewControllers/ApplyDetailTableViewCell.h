//
//  ApplyDetailTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/11.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ApplyDetailTableViewCell : BaseTableViewCell
@property (strong,nonatomic) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@end

NS_ASSUME_NONNULL_END
