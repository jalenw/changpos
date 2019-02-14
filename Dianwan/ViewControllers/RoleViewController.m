//
//  RoleViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/21.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "RoleViewController.h"

@interface RoleViewController ()

@end

@implementation RoleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"分润细则";
    self.scrollView.contentSize = CGSizeMake(ScreenWidth, 580);
    
    if (self.dict) {
        self.name.text = [self.dict safeStringForKey:@"gc_name"];
        self.desc.text = [NSString stringWithFormat:@"%@", [self.dict safeStringForKey:@"goods_name"]];
        self.model.text = [NSString stringWithFormat:@"%@",[self.dict safeStringForKey:@"goods_serial"]];
        self.paytype1.text = [NSString stringWithFormat:@"%@%%", [self.dict safeStringForKey:@"cloud_admin_share"]];
        self.paytype2.text = [NSString stringWithFormat:@"%@%%", [self.dict safeStringForKey:@"lineCard_admin_share"]];
        self.paytype3.text = [NSString stringWithFormat:@"%@%%", [self.dict safeStringForKey:@"bankCard_admin_share"]];
        self.paytype4.text = [NSString stringWithFormat:@"%@%%", [self.dict safeStringForKey:@"quickPay_admin_share"]];
        self.paytype5.text = [NSString stringWithFormat:@"%@%%", [self.dict safeStringForKey:@"scaveCode_admin_share"]];
        self.card.text = [NSString stringWithFormat:@"%@", [self.dict safeStringForKey:@"admin_top_share"]];
        self.actReward.text = [NSString stringWithFormat:@"%@", [self.dict safeStringForKey:@"activate_rewards"]];
        self.recommendReward.text = [NSString stringWithFormat:@"%@", [self.dict safeStringForKey:@"goods_rewards"]];
    }
    
    if (self.snDict) {
        self.name.text = [self.snDict safeStringForKey:@"gc_name"];
        self.desc.text = [NSString stringWithFormat:@"%@ %@", [self.snDict safeStringForKey:@"goods_name"],[self.snDict safeStringForKey:@"goods_serial"]];
        self.paytype1.text = [NSString stringWithFormat:@"%@%%", [self.snDict safeStringForKey:@"cloud_merchant_rate"]];
        self.paytype2.text = [NSString stringWithFormat:@"%@%%", [self.snDict safeStringForKey:@"lineCard_merchant_rate"]];
        self.paytype3.text = [NSString stringWithFormat:@"%@%%", [self.snDict safeStringForKey:@"bankCard_merchant_rate"]];
        self.paytype4.text = [NSString stringWithFormat:@"%@%%", [self.snDict safeStringForKey:@"quickPay_merchant_rate"]];
        self.paytype5.text = [NSString stringWithFormat:@"%@%%", [self.snDict safeStringForKey:@"scaveCode_merchant_rate"]];
        self.card.text = [NSString stringWithFormat:@"0"];
        self.actReward.text = [NSString stringWithFormat:@"0"];
        self.recommendReward.text = [NSString stringWithFormat:@"0"];
    }
}
@end
