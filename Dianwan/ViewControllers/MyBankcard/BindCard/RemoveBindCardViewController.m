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
@property (weak, nonatomic) IBOutlet UIImageView *removeImageview;

@end

@implementation RemoveBindCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(48, 46, 58);
    self.card_id =[self.model.card_id stringValue];
    self.removeImageview.userInteractionEnabled = YES;
    UITapGestureRecognizer *removetap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(removeBankCardAction)];
    [self  setUI];
    
}

-(void)setUI{
    self.cardNumberLabel.text = [NSString stringWithFormat:@"**** **** **** %@",[self.model.bank_card substringFromIndex:self.model.bank_card.length-4]];
    self.cardBankNameLabel.text = self.model.bank_name;
//    [self.bankImageView sd_setImageWithURL:[NSURL URLWithString:self.model.bank_img]];
}

- (void)removeBankCardAction{

    [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"card_id":self.card_id,
                               @"client":@"ios"
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/member_bank/del_bank_card" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
                [AlertHelper showAlertWithTitle:@"解绑成功" duration:3];
                [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            NSLog(@"手机验证错误---%@",requestFailed);
        }
        
    }];
    
}
@end
