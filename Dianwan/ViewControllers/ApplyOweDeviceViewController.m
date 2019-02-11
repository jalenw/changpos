//
//  ApplyOweDeviceViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/17.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "ApplyOweDeviceViewController.h"
#import "OweDeviceTableViewCell.h"
@interface ApplyOweDeviceViewController () <UITextFieldDelegate>
{
    NSMutableArray *array;
}
@end

@implementation ApplyOweDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"申请自备机入网";
    [self setupForDismissKeyboard];
    array = [[NSMutableArray alloc]init];
    [array addObject:@""];
    self.tableView.tableHeaderView = self.headView;
    // Do any additional setup after loading the view from its nib.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return array.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"OweDeviceTableViewCell";
    OweDeviceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(cell == nil){
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        cell = [nib objectAtIndex:0];
        cell.tf.delegate = self;
    }
    cell.tf.tag = indexPath.row;
    cell.tf.text = [array objectAtIndex:indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (IBAction)confirmAct:(UIButton *)sender {
    if (self.name.text.length==0) {
        [AlertHelper showAlertWithTitle:@"请输入厂商名"];
        return;
    }
    NSMutableString *mutStr = [[NSMutableString alloc]init];
    for (NSString * str in array) {
        if (str.length>0) {
            [mutStr appendString:[NSString stringWithFormat:@"%@,",str]];
        }
    }
    if (array.count>1&&[mutStr containsString:@","]) {
        [mutStr replaceCharactersInRange:NSMakeRange(mutStr.length-1, 1) withString:@""];
    }
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/applicationForSelf" params:@{@"manufacturer_name":self.name.text,@"machine_model":self.model.text,@"data_content":mutStr} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [AlertHelper showAlertWithTitle:@"提交申请成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

- (IBAction)subtractAct:(UIButton *)sender {
    if (array.count==1) {
        [AlertHelper showAlertWithTitle:@"至少保留一个"];
    }else
    {
        [array removeLastObject];
        [self.tableView reloadData];
    }
}

- (IBAction)addAct:(UIButton *)sender {
    [array addObject:@""];
    [self.tableView reloadData];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [array replaceObjectAtIndex:textField.tag withObject:textField.text];
}
@end
