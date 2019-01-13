//
//  RemoveBindCardViewController.m
//  BaseProject
//
//  Created by Mac on 2018/11/1.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "RemoveBindCardViewController.h"
#import "CardInfoModel.h"

@interface RemoveBindCardViewController ()
@property(nonatomic,strong)NSString *card_id;
@property (weak, nonatomic) IBOutlet UIImageView *bankImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardBankNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;

@end

@implementation RemoveBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(48, 46, 58);
    self.card_id =[self.model.card_id stringValue];
    [self  setUI];
}

-(void)setUI{
    self.cardNumberLabel.text =self.model.bank_card;
    self.cardBankNameLabel.text =self.model.bank_name;
    [self.bankImageView sd_setImageWithURL:[NSURL URLWithString:self.model.bank_img]];
}

- (IBAction)removeBankCardAction:(UIButton *)sender {

    [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"card_id":self.card_id,
                               @"client":@"ios"
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/member_bank/del_bank_card" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            if ([data safeIntForKey:@"code"]==200) {
                [SVProgressHUD showSuccessWithStatus:@"解绑成功"];
                [self.navigationController popViewControllerAnimated:YES];
                
            }else{
                [AlertHelper showAlertWithTitle:error];
            }
        }else{
            NSLog(@"手机验证错误---%@",requestFailed);
        }
        
    }];
    
}
@end
