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

@property (weak, nonatomic) IBOutlet UIButton *nextbtn;
@end

@implementation TransfersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"调拨详情";
    
    [self setupUI];
    self.view.backgroundColor = RGB(48, 46, 58);
}

-(void)setupUI{
    self.reactiverLabel.text = [self.dict safeStringForKey:@"recipient_name"];
    self.transfersLabel.text = [self.dict safeStringForKey:@"member_Initiator"];
    self.reactiverPhoneLabel.text = [self.dict safeStringForKey:@"recipient_mobile"];
    self.machinesName.text = [self.dict safeStringForKey:@"equipment"];
    self.snLabel.text = [self.dict safeStringForKey:@"sn_code"];
    self.transfersTimeLabel.text = [self.dict safeStringForKey:@"equipment_time"];
    self.machinesCountLabel.text =[NSString stringWithFormat:@"%@",[self.dict safeNumberForKey:@"equipment_num"]];
    if ([self.dict safeIntForKey:@"is_type"] ==1) {
       
        self.nextbtn.userInteractionEnabled =NO;
        [self.nextbtn setTitle:@"已 收 款" forState:UIControlStateNormal];
        [self.nextbtn setBackgroundColor: RGB(200 , 200, 200)];
    }else {
        self.nextbtn.userInteractionEnabled =YES;
        [self.nextbtn setTitle:@"确 定 收 款" forState:UIControlStateNormal];
        [self.nextbtn setBackgroundColor: RGB(251 , 182, 8)];

    }
}


- (IBAction)btnClickAction:(UIButton *)sender {
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/allocationConfirm" params:@{@"id":[self.dict safeNumberForKey:@"id"]} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            [AlertHelper showAlertWithTitle:[data safeStringForKey:@"result"]];
            self.nextbtn.userInteractionEnabled =NO;
            [self.nextbtn setTitle:@"已 收 款" forState:UIControlStateNormal];
            [self.nextbtn setBackgroundColor: RGB(200 , 200, 200)];
        }else{
             [AlertHelper showAlertWithTitle:error];
        }
    }];
}
@end
