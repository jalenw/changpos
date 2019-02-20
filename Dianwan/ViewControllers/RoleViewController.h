//
//  RoleViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/21.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

@interface RoleViewController : BaseViewController
@property (assign,nonatomic) int type;//1 商户详情
@property (strong,nonatomic) NSDictionary *dict;
@property (strong,nonatomic) NSDictionary *snDict;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *desc;
@property (weak, nonatomic) IBOutlet UILabel *model;
@property (weak, nonatomic) IBOutlet UILabel *paytype1;
@property (weak, nonatomic) IBOutlet UILabel *paytype2;
@property (weak, nonatomic) IBOutlet UILabel *paytype3;
@property (weak, nonatomic) IBOutlet UILabel *paytype4;
@property (weak, nonatomic) IBOutlet UILabel *paytype5;
@property (weak, nonatomic) IBOutlet UILabel *card;
@property (weak, nonatomic) IBOutlet UILabel *actReward;
@property (weak, nonatomic) IBOutlet UILabel *recommendReward;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *actView;
@property (weak, nonatomic) IBOutlet UIView *recView;
@end
