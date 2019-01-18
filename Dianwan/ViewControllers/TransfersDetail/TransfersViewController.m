//
//  TransfersViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/17.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "TransfersViewController.h"

@interface TransfersViewController ()
@property (weak, nonatomic) IBOutlet UILabel *transfersLabel;
@property (weak, nonatomic) IBOutlet UILabel *reactiverLabel;
@property (weak, nonatomic) IBOutlet UILabel *reactiverPhoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *machinesName;
@property (weak, nonatomic) IBOutlet UILabel *snLabel;
@property (weak, nonatomic) IBOutlet UILabel *machinesCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *transfersTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@end

@implementation TransfersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"调拨详情";
    self.view.backgroundColor = RGB(48, 46, 58);
    [self setupUI];
    [self.nextButton addTarget:self action:@selector(btnClickAction) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)setupUI{
    self.reactiverLabel.text = [self.dict safeStringForKey:@"recipient_name"];
    self.transfersLabel.text = [self.dict safeStringForKey:@"member_Initiator"];
    self.reactiverPhoneLabel.text = [self.dict safeStringForKey:@"recipient_mobile"];
    self.machinesName.text = [self.dict safeStringForKey:@"equipment"];
    self.snLabel.text = [self.dict safeStringForKey:@"sn_code"];
    self.transfersTimeLabel.text = [self.dict safeStringForKey:@"equipment_time"];
    self.machinesCountLabel.text =[NSString stringWithFormat:@"%@",[self.dict safeNumberForKey:@"equipment_num"]];
    [self.nextButton setTitle:@"已收款" forState:UIControlStateNormal];
    if ([self.dict safeIntForKey:@"is_type"] ==1) {
        self.nextButton.enabled =NO;
        self.nextButton.backgroundColor =RGB(125, 125, 125);
    }else {
        self.nextButton.enabled =YES;
        self.nextButton.backgroundColor =RGB(245, 180, 6);
    }
}
-(void)btnClickAction{
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/allocationConfirm" params:@{@"id":[self.dict safeNumberForKey:@"id"]} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [AlertHelper showAlertWithTitle:[data safeStringForKey:@"result"]];
            self.nextButton.enabled =NO;
             self.nextButton.backgroundColor =RGB(125, 125, 125);
        }else{
             [AlertHelper showAlertWithTitle:error];
        }
    }];
}
@end
