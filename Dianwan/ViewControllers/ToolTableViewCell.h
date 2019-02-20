//
//  ToolTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/21.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ToolTableViewCell : BaseTableViewCell
@property (strong,nonatomic) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *snLb;
@property (weak, nonatomic) IBOutlet UILabel *timeLb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@end

NS_ASSUME_NONNULL_END
