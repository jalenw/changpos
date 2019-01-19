//
//  StoreTableViewCell.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/19.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StoreTableViewCell : UITableViewCell
@property (strong,nonatomic) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *storeNameLb;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *productNameLb;
@property (weak, nonatomic) IBOutlet UILabel *seriesName;
@property (weak, nonatomic) IBOutlet UIButton *roleBt;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;
@property (weak, nonatomic) IBOutlet UILabel *totalLb;

@end

NS_ASSUME_NONNULL_END
