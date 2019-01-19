//
//  ApplyOweDeviceViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ApplyOweDeviceViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *model;
- (IBAction)confirmAct:(UIButton *)sender;
- (IBAction)subtractAct:(UIButton *)sender;
- (IBAction)addAct:(UIButton *)sender;
@end

NS_ASSUME_NONNULL_END
