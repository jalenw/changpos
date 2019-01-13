//
//  CertificationSuccessViewController.m
//  BaseProject
//
//  Created by Mac on 2018/11/1.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "CertificationSuccessViewController.h"


@interface CertificationSuccessViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *acoverImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *cardNumberLabel;

@end

@implementation CertificationSuccessViewController



-(void)setUI{
    [self.acoverImageView sd_setImageWithURL:[NSURL URLWithString:AppDelegateInstance.defaultUser.member_avatar]];
    self.usernameLabel.text =[NSString stringWithFormat:@"%@", AppDelegateInstance.defaultUser.member_name];
    self.cardNumberLabel.text =[NSString stringWithFormat:@"%@", AppDelegateInstance.defaultUser.idcard];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    [self setUI];
    self.view.backgroundColor = RGB(48, 46, 58);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
