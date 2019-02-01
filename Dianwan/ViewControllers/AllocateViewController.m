//
//  AllocateViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "AllocateViewController.h"
#import "LZHAreaPickerView.h"
@interface AllocateViewController ()
{
    NSString *goods_id;
    NSString *sn_code;
    NSDictionary *member_info;
}
@end

@implementation AllocateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"发起调拨";
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)productAct:(UIButton *)sender {
    NSMutableDictionary *param = [HTTPClientInstance newDefaultParameters];
    if (self.others_member_id) {
        [param setValue:self.others_member_id forKey:@"others_member_id"];
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/myMachine" params:param block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
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
    if (goods_id.length==0) {
        return;
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/showProductSNCode" params:@{@"goods_id":goods_id} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            NSArray *array = [[data safeDictionaryForKey:@"result"] safeArrayForKey:@"data"];
            if (array.count>0) {
                LZHAreaPickerView *pickerView = [[LZHAreaPickerView alloc]init];
                pickerView.array = array;
                pickerView.name = @"sn_code";
                [pickerView setBlock:^(NSDictionary *dict) {
                    self.snTf.text = [dict safeStringForKey:@"sn_code"];
                    sn_code = [NSString stringWithFormat:@"%lld",[dict safeLongLongForKey:@"sn_code"]];
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

- (IBAction)partnerAct:(UIButton *)sender {
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/get_transfer_mb_list" params:@{@"rate_action":@"2"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            NSArray *array = [[data safeDictionaryForKey:@"result"] safeArrayForKey:@"list"];
            if (array.count>0) {
                LZHAreaPickerView *pickerView = [[LZHAreaPickerView alloc]init];
                pickerView.array = array;
                pickerView.name = @"member_name";
                [pickerView setBlock:^(NSDictionary *dict) {
                    self.partnerTf.text = [dict safeStringForKey:@"member_name"];
                    member_info = dict;
                }];
                [pickerView showPicker];
            }
            else
            {
                [AlertHelper showAlertWithTitle:@"暂无渠道"];
            }
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

- (IBAction)confirmAct:(UIButton *)sender {
    if ([Tooles isEmpty:goods_id]) {
        [AlertHelper showAlertWithTitle:@"请选择产品"];
        return;
    }
    if ([Tooles isEmpty:sn_code]) {
        [AlertHelper showAlertWithTitle:@"请选择SN号产品"];
        return;
    }
    if ([self.totalTf.text integerValue]==0) {
        [AlertHelper showAlertWithTitle:@"请选择调拨数量"];
        return;
    }
    if (member_info==nil) {
        [AlertHelper showAlertWithTitle:@"请选择代理商"];
        return;
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/initiateATransferNew" params:@{@"goods_id":goods_id,@"sn_code":sn_code,@"num":self.totalTf.text,@"member_name":[member_info safeStringForKey:@"member_name"],@"member_mobile":[member_info safeStringForKey:@"member_mobile"]} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [AlertHelper showAlertWithTitle:@"提交成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}
@end
