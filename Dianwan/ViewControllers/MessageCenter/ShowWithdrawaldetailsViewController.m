//
//  ShowWithdrawaldetailsViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/16.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "ShowWithdrawaldetailsViewController.h"

@interface ShowWithdrawaldetailsViewController ()
@property (weak, nonatomic) IBOutlet UIView *contentview;

@end

@implementation ShowWithdrawaldetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的银行卡";
    [self setupDict];
    self.view.backgroundColor = RGB(48, 46, 58);
    self.contentview.backgroundColor =RGB(48, 46, 58);
}

-(void)setupDict
{
    
    self.moneyCountLabel.text =[NSString stringWithFormat:@"¥ %@",[self.dict safeStringForKey:@"pdc_amount"]];
     self.showMoneycountLabel.text = [self.dict safeStringForKey:@"pdc_amount"];
     self.createTimeLabel.text = [self.dict safeStringForKey:@"pdc_addtime"];
     self.arriveTimeLabel.text = [self.dict safeStringForKey:@"pdc_expect_time"];
     self.bankNameLabel.text = [self.dict safeStringForKey:@"pdc_bank_name"];
     self.statueLabel.text = [self.dict safeStringForKey:@"pdc_payment_state"];
     self.idLabel.text = [self.dict safeStringForKey:@""];
     self.poundageLabel.text = [self.dict safeStringForKey:@""];
    
    
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
