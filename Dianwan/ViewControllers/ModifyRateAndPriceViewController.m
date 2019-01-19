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
{
    NSString *cloud_merchant_rate;
    NSString *lineCard_merchant_rate;
    NSString *bankCard_merchant_rate;
    NSString *quickPay_merchant_rate;
    NSString *scaveCode_merchant_rate;
    UILabel *tempLb;
    NSString *goods_id;
    NSString *activate_rewards;
}
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
        self.productView.hidden = NO;
        self.rewardView.hidden = NO;
        self.payView.hidden = YES;
    }
}

- (IBAction)editAct:(UIButton *)sender {
    [self.view addSubview:self.modifyView];
    if (sender.tag==0) {
        [self setupModifyView:@"云闪付" :@"输入的值保留小数点后3位" :self.rate1Lb];
    }
    if (sender.tag==1) {
        [self setupModifyView:@"信用卡" :@"输入的值保留小数点后3位" :self.rate2Lb];
    }
    if (sender.tag==2) {
        [self setupModifyView:@"银行卡" :@"输入的值保留小数点后3位" :self.rate3Lb];
    }
    if (sender.tag==3) {
        [self setupModifyView:@"快捷支付" :@"输入的值保留小数点后3位" :self.rate4Lb];
    }
    if (sender.tag==4) {
        [self setupModifyView:@"扫码支付" :@"输入的值保留小数点后3位" :self.rate5Lb];
    }
    if (sender.tag==5) {
        [self setupModifyView:@"激活奖励金额" :@"输入的值为整数" :self.priceLb];
    }
}

-(void)setupModifyView:(NSString*)title :(NSString*)placeHolder :(UILabel*)targetLabel
{
    self.modifyTitleLb.text = title;
    self.modifyTf.text = @"";
    self.modifyTf.placeholder = placeHolder;
    tempLb = targetLabel;
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
                pickerView.nameArray = @[@"gc_name",@"goods_name",@"goods_serial"];
                [pickerView setBlock:^(NSDictionary *dict) {
                    NSMutableString *mutStr = [[NSMutableString alloc]init];
                    for (NSString *str in @[@"gc_name",@"goods_name",@"goods_serial"]) {
                        [mutStr appendString:[dict safeStringForKey:str]];
                        [mutStr appendString:@" "];
                    }
                    self.productTf.text = mutStr;
                    goods_id = [NSString stringWithFormat:@"%d",[dict safeIntForKey:@"goods_id"]];
                    [self loadProductData:goods_id];
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

-(void)loadProductData:(NSString*)productId
{
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/showMyAllocationRateInfo" params:@{@"goods_id":productId} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            NSDictionary *dict = [data safeDictionaryForKey:@"result"];
            self.rate1Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"cloud_admin_share"]];
            self.rate2Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"lineCard_admin_share"]];
            self.rate3Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"bankCard_admin_share"]];
            self.rate4Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"quickPay_admin_share"]];
            self.rate5Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"scaveCode_admin_sahre"]];
            self.priceLb.text = [NSString stringWithFormat:@"%@元",[dict safeStringForKey:@"activate_rewards"]];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

- (IBAction)snAct:(UIButton *)sender {
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/adjustmentRate" params:@{@"sn_code":self.snLabel.text} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            NSDictionary *dict = [data safeDictionaryForKey:@"result"];
            self.rate1Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"cloud_merchant_rate"]];
            self.rate2Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"lineCard_merchant_rate"]];
            self.rate3Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"bankCard_merchant_rate"]];
            self.rate4Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"quickPay_merchant_rate"]];
            self.rate5Lb.text = [NSString stringWithFormat:@"%@%%",[dict safeStringForKey:@"scaveCode_merchant_rate"]];
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
    if (tempLb == self.rate1Lb) {
        cloud_merchant_rate = [NSString stringWithFormat:@"%@",self.modifyTf.text];
        self.rate1Lb.text = [NSString stringWithFormat:@"%@ 改为 %@%%",[self.rate1Lb.text componentsSeparatedByString:@"改为"][0], cloud_merchant_rate];
    }
    if (tempLb == self.rate2Lb) {
        lineCard_merchant_rate = [NSString stringWithFormat:@"%@",self.modifyTf.text];
        self.rate2Lb.text = [NSString stringWithFormat:@"%@ 改为 %@%%",[self.rate2Lb.text componentsSeparatedByString:@"改为"][0], lineCard_merchant_rate];
    }
    if (tempLb == self.rate3Lb) {
        bankCard_merchant_rate = [NSString stringWithFormat:@"%@",self.modifyTf.text];
        self.rate3Lb.text = [NSString stringWithFormat:@"%@ 改为 %@%%",[self.rate3Lb.text componentsSeparatedByString:@"改为"][0], bankCard_merchant_rate];
    }
    if (tempLb == self.rate4Lb) {
        quickPay_merchant_rate = [NSString stringWithFormat:@"%@",self.modifyTf.text];
        self.rate4Lb.text = [NSString stringWithFormat:@"%@ 改为 %@%%",[self.rate4Lb.text componentsSeparatedByString:@"改为"][0], quickPay_merchant_rate];
    }
    if (tempLb == self.rate5Lb) {
        scaveCode_merchant_rate = [NSString stringWithFormat:@"%@",self.modifyTf.text];
        self.rate5Lb.text = [NSString stringWithFormat:@"%@ 改为 %@%%",[self.rate5Lb.text componentsSeparatedByString:@"改为"][0], scaveCode_merchant_rate];
    }
    if (tempLb == self.priceLb) {
        activate_rewards = [NSString stringWithFormat:@"%@",self.modifyTf.text];
        self.priceLb.text = [NSString stringWithFormat:@"%@ 改为 %@元",[self.priceLb.text componentsSeparatedByString:@"改为"][0], activate_rewards];
    }
}

- (IBAction)confirmAct:(UIButton *)sender {
    if (self.type==0) {
        if (self.snLabel.text.length==0) {
            return;
        }
        NSMutableDictionary *params = [HTTPClientInstance newDefaultParameters];
        [params setValue:self.snLabel.text forKey:@"sn_code"];
        if (cloud_merchant_rate) {
            [params setValue:cloud_merchant_rate forKey:@"cloud_merchant_rate"];
        }
        if (lineCard_merchant_rate) {
            [params setValue:lineCard_merchant_rate forKey:@"lineCard_merchant_rate"];
        }
        if (bankCard_merchant_rate) {
            [params setValue:bankCard_merchant_rate forKey:@"bankCard_merchant_rate"];
        }
        if (quickPay_merchant_rate) {
            [params setValue:quickPay_merchant_rate forKey:@"quickPay_merchant_rate"];
        }
        if (scaveCode_merchant_rate) {
            [params setValue:scaveCode_merchant_rate forKey:@"scaveCode_merchant_rate"];
        }
        [SVProgressHUD show];
        [[ServiceForUser manager]postMethodName:@"mobile/Mystock/updateSubmitAdjustmentRate" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            if (status) {
                [AlertHelper showAlertWithTitle:@"提交申请成功"];
            }else{
                [AlertHelper showAlertWithTitle:error];
            }
        }];
    }else if (self.type==1) {
        if (goods_id.length==0) {
            return;
        }
        NSMutableDictionary *params = [HTTPClientInstance newDefaultParameters];
        [params setValue:goods_id forKey:@"goods_id"];
        if (cloud_merchant_rate) {
            [params setValue:cloud_merchant_rate forKey:@"cloud_admin_share"];
        }
        if (lineCard_merchant_rate) {
            [params setValue:lineCard_merchant_rate forKey:@"lineCard_admin_share"];
        }
        if (bankCard_merchant_rate) {
            [params setValue:bankCard_merchant_rate forKey:@"bankCard_admin_share"];
        }
        if (quickPay_merchant_rate) {
            [params setValue:quickPay_merchant_rate forKey:@"quickPay_admin_share"];
        }
        if (scaveCode_merchant_rate) {
            [params setValue:scaveCode_merchant_rate forKey:@"scaveCode_admin_share"];
        }
        [SVProgressHUD show];
        [[ServiceForUser manager]postMethodName:@"mobile/Mystock/adjustMyRates" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            if (status) {
                [AlertHelper showAlertWithTitle:@"提交申请成功"];
            }else{
                [AlertHelper showAlertWithTitle:error];
            }
        }];
    }else if (self.type==2) {
        if (activate_rewards.length==0) {
            return;
        }
        NSMutableDictionary *params = [HTTPClientInstance newDefaultParameters];
        [params setValue:goods_id forKey:@"goods_id"];
        [params setValue:activate_rewards forKey:@"activate_rewards"];
        [SVProgressHUD show];
        [[ServiceForUser manager]postMethodName:@"mobile/Mystock/modifyActivateRewards" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            if (status) {
                [AlertHelper showAlertWithTitle:@"提交申请成功"];
            }else{
                [AlertHelper showAlertWithTitle:error];
            }
        }];
    }
}
@end
