//
//  MyStoreViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyStoreViewController : BaseViewController
@property (strong, nonatomic) NSString *others_member_id;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *bt;
- (IBAction)confirmAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
