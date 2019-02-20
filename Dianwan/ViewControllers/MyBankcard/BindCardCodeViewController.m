//
//  BindCardCodeViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/18.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BindCardCodeViewController.h"
#import "SYPasswordView.h"

@interface BindCardCodeViewController ()
@property(nonatomic,strong)SYPasswordView *pwInputView;
@end

@implementation BindCardCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加银行卡第一步";
    
    self.pwInputView = [[SYPasswordView alloc] initWithFrame:CGRectMake(20, self.words.bottom+30, ScreenWidth - 40, 45)];
    __weak BindCardCodeViewController *weakSelf = self;
    self.pwInputView.inputAllBlodk=^(NSString *pwnumber){
        [weakSelf.pwInputView clearUpPassword];
        [SVProgressHUD show];
        NSDictionary *params =@{
                                @"password":pwnumber
                                };
        [[ServiceForUser manager]postMethodName:@"mobile/memberbuy/check_pd_pwd2" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            if (status) {
                [weakSelf.delegate codeValDone];
            }
            else
            {
                [AlertHelper showAlertWithTitle:error];
            }
        }];
    };
    self.pwInputView.layer.cornerRadius = 5;
    self.pwInputView.layer.masksToBounds =YES;
    [self.view addSubview: self.pwInputView ];
    // Do any additional setup after loading the view from its nib.
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
