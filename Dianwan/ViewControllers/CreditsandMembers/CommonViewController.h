//
//  CommonViewController.h
//  Dianwan
//
//  Created by Yang on 2019/1/20.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CommonViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong) NSString *type;
@property(nonatomic,copy) void (^allcountBlock)(NSString *count);

@end

NS_ASSUME_NONNULL_END
