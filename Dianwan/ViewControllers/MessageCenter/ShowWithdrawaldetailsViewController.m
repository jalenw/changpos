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
@property(nonatomic,strong)NSString *formalities;
@end

@implementation ShowWithdrawaldetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的银行卡";
    [self getFormalities];
    [self setupDict];
    self.view.backgroundColor = RGB(48, 46, 58);
    self.contentview.backgroundColor =RGB(48, 46, 58);
}


-(void)getFormalities{
    [[ServiceForUser manager]postMethodName:@"mobile/index/get_pd_cash_setting_info" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if(status){
            _formalities =  [[data safeDictionaryForKey:@"result"] safeStringForKey:@"pd_cash_service_charge"] ;
            
            [self setupDict];
//            singlaFormalities =  [[[data safeDictionaryForKey:@"result"] safeStringForKey:@"single_pd_cash_price"] floatValue ];
        }
        else
        {
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}

-(void)setupDict
{
    self.moneyCountLabel.text =[NSString stringWithFormat:@"¥ %@",[self.dict safeStringForKey:@"pdc_amount"]];
     self.showMoneycountLabel.text = [self.dict safeStringForKey:@"pdc_amount"];
     self.createTimeLabel.text = [self.dict safeStringForKey:@"pdc_addtime"];
     self.arriveTimeLabel.text = [self.dict safeStringForKey:@"pdc_expect_time"];
     self.bankNameLabel.text = [self.dict safeStringForKey:@"pdc_bank_name"];
     self.statueLabel.text = [self.dict safeStringForKey:@"pdc_payment_state"];
     self.idLabel.text = [self.dict safeStringForKey:@"pdc_sn"];
     self.poundageLabel.text = [NSString stringWithFormat:@"%.4f",[[self.dict safeStringForKey:@"pdc_amount"] floatValue]  *[_formalities floatValue]];
    
    
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
