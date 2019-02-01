//
//  ApplyApproveViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/1.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplyApproveViewController : BaseViewController
@property (assign, nonatomic) int type;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

NS_ASSUME_NONNULL_END
