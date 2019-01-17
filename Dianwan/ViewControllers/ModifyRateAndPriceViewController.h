//
//  ModifyRateAndPriceViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/16.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface ModifyRateAndPriceViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIView *productView;
@property (weak, nonatomic) IBOutlet UIView *snView;
@property (weak, nonatomic) IBOutlet UIView *payView;
@property (weak, nonatomic) IBOutlet UIView *awardView;
@property (weak, nonatomic) IBOutlet UITextField *productTf;
@property (weak, nonatomic) IBOutlet UITextField *snLabel;
@property (weak, nonatomic) IBOutlet UILabel *rate1Lb;
@property (weak, nonatomic) IBOutlet UILabel *rate2Lb;
@property (weak, nonatomic) IBOutlet UILabel *rate3Lb;
@property (weak, nonatomic) IBOutlet UILabel *rate4Lb;
@property (weak, nonatomic) IBOutlet UILabel *rate5Lb;
@property (weak, nonatomic) IBOutlet UILabel *priceLb;

@property (strong, nonatomic) IBOutlet UIView *modifyView;
@property (weak, nonatomic) IBOutlet UITextField *modifyTf;
@property (weak, nonatomic) IBOutlet UILabel *modifyTitleLb;


- (IBAction)editAct:(UIButton *)sender;
- (IBAction)productAct:(UIButton *)sender;
- (IBAction)snAct:(UIButton *)sender;

- (IBAction)removeModifyView:(UIButton *)sender;
- (IBAction)confirmModifyView:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
