//
//  CheckDetailViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/1.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckDetailViewController : BaseViewController
@property (strong,nonatomic) NSString *transfer_id;
@property (weak, nonatomic) IBOutlet UILabel *nameA;
@property (weak, nonatomic) IBOutlet UILabel *nameB;
@property (weak, nonatomic) IBOutlet UILabel *phone;
@property (weak, nonatomic) IBOutlet UILabel *toolName;
@property (weak, nonatomic) IBOutlet UILabel *snCode;
@property (weak, nonatomic) IBOutlet UILabel *total;
@property (weak, nonatomic) IBOutlet UILabel *time;
@property (weak, nonatomic) IBOutlet UIButton *bt1;
@property (weak, nonatomic) IBOutlet UIButton *bt2;
@property (weak, nonatomic) IBOutlet UIButton *tips;
- (IBAction)checkAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
