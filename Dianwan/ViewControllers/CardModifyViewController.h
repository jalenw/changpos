//
//  CardModifyViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/31.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface CardModifyViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *cardNumber;
@property (weak, nonatomic) IBOutlet UITextField *bankName;
@property (weak, nonatomic) IBOutlet UITextField *branchName;
@property (weak, nonatomic) IBOutlet UITextField *phone;
- (IBAction)doneAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
