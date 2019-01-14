//
//  ApplyShowDetailViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/14.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "ApplyShowDetailViewController.h"

@interface ApplyShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumLabel;
@property (weak, nonatomic) IBOutlet UILabel *CompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *machineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *machineModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelLabel;
@property (weak, nonatomic) IBOutlet UIButton *agressBtn;
@property (weak, nonatomic) IBOutlet UIButton *disagressBtn;

@end

@implementation ApplyShowDetailViewController

- (IBAction)dealApplyAction:(UIButton *)sender {
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/parentExamine" params:@{@"id":@(self.idNum),@"type":@(sender.tag)} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
             [AlertHelper showAlertWithTitle:[data safeStringForKey:@"result"]];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
        
    }];
    
}





- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请详情";
    self.view.backgroundColor = RGB(246, 246, 246);
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/examineAllocationDetail" params:@{@"id":@(self.idNum)} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            NSDictionary *result = [data safeDictionaryForKey:@"result"];
            [self setupUI:result];
            
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    
    }];
}

-(void)setupUI:(NSDictionary *)dict{
    if ([dict safeIntForKey:@"is_type"]==1) {
        self.agressBtn.hidden =NO;
        self.disagressBtn.hidden =NO;
    }
    
     self.titlelLabel.text =[dict safeStringForKey:@"title"];
    self.nameLabel.text =[dict safeStringForKey:@"member_name"];
    self.phoneNumLabel.text =[dict safeStringForKey:@"member_mobile"];
    self.CompanyLabel.text =[dict safeStringForKey:@"gc_name"];
    switch ([[dict safeStringForKey:@"examine_type"] integerValue]) {
        case 0:
            self.stateLabel.text = @"待上级审核 ";
            break;
        case 1:
            
            self.stateLabel.text = @"待平台审核 ";
            break;
        case 2:
            
            self.stateLabel.text = @"审核通过 ";
            break;
        case 3:
            
            self.stateLabel.text = @"审核失败 ";
            break;
            
    }
    self.machineNameLabel.text =[dict safeStringForKey:@"goods_name"];
    self.machineModeLabel.text =[dict safeStringForKey:@"goods_serial"];
    self.changeRateLabel.text =[dict safeStringForKey:@"decoration"];
  
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end