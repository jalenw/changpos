//
//  MerchantViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MerchantViewController : BaseViewController
@property (strong,nonatomic)NSString *keyword;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
