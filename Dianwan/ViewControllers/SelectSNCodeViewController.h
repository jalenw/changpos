//
//  SelectSNCodeViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/11.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SelectSNCodeViewController : BaseViewController
@property (strong, nonatomic) NSArray *array;
@property (strong, nonatomic) NSMutableArray *data;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,copy) void (^block)(NSString*) ;
@end

NS_ASSUME_NONNULL_END
