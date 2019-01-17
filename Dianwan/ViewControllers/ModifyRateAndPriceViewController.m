//
//  ModifyRateAndPriceViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/16.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ModifyRateAndPriceViewController.h"
#import "LZHAreaPickerView.h"
@interface ModifyRateAndPriceViewController ()

@end

@implementation ModifyRateAndPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupForDismissKeyboard];
    self.modifyView.frame = ScreenBounds;
    if (self.type==0) {
        self.title = @"修改我的商户费率";
        self.snView.hidden = NO;
        self.productView.hidden = YES;
        self.rewardView.hidden = YES;
        self.payView.hidden = NO;
    }else if (self.type==1) {
        self.title = @"申请修改结算底价";
        self.snView.hidden = YES;
        self.productView.hidden = NO;
        self.rewardView.hidden = YES;
        self.payView.hidden = NO;
    }else if (self.type==2) {
        self.title = @"修改激活奖励金额";
        self.snView.hidden = YES;
        self.productView.hidden = YES;
        self.rewardView.hidden = NO;
        self.payView.hidden = YES;
        self.rewardView.top = 20;
    }
}

- (IBAction)editAct:(UIButton *)sender {
    [self.view addSubview:self.modifyView];
}

- (IBAction)productAct:(UIButton *)sender {
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myMachine" params:nil block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            NSArray *array = [[data safeDictionaryForKey:@"result"] safeArrayForKey:@"list"];
            if (array.count>0) {
                LZHAreaPickerView *pickerView = [[LZHAreaPickerView alloc]init];
                pickerView.array = array;
                pickerView.name = @"goods_name";
                [pickerView setBlock:^(NSDictionary *dict) {
                    
                }];
                [pickerView showPicker];
            }
            else
            {
                [AlertHelper showAlertWithTitle:@"暂无产品"];
            }
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

- (IBAction)snAct:(UIButton *)sender {
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/adjustmentRate" params:@{@"sn_code":self.snLabel.text} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
         
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

- (IBAction)removeModifyView:(UIButton *)sender {
    [self.modifyView removeFromSuperview];
}

- (IBAction)confirmModifyView:(UIButton *)sender {
    [self.modifyView removeFromSuperview];
}
@end
