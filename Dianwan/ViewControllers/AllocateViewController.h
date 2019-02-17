//
//  AllocateViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface AllocateViewController : BaseViewController
//@property (strong, nonatomic) NSString *others_member_id;
@property (weak, nonatomic) IBOutlet UITextField *productTf;
@property (weak, nonatomic) IBOutlet UITextField *snTf;
@property (weak, nonatomic) IBOutlet UITextField *totalTf;
@property (weak, nonatomic) IBOutlet UITextField *partnerTf;
@property (weak, nonatomic) IBOutlet UITextField *phone;
- (IBAction)productAct:(UIButton *)sender;
- (IBAction)snAct:(UIButton *)sender;
- (IBAction)partnerAct:(UIButton *)sender;
- (IBAction)confirmAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
