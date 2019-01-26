//
//  WalletwithdrawalViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/25.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "WalletwithdrawalViewController.h"
#import "PassWordView.h"
#import "UIView+EasyLayout.h"
#import "CardInfoModel.h"
#import "CardBindViewController.h"

@interface WalletwithdrawalViewController ()
@property(nonatomic,strong)NSMutableArray *cardArray;


@property (strong, nonatomic) IBOutlet UIView *passInputWordView;
@property (weak, nonatomic) IBOutlet UIImageView *cardImageView;
@property (weak, nonatomic) IBOutlet UILabel *cardBankNameLabel;
@property (weak, nonatomic) IBOutlet UITextField *amountTextfiled;
@property (weak, nonatomic) IBOutlet PassWordView *pwview;
@property (weak, nonatomic) IBOutlet UILabel *moneyNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *yueLabel;
@property (weak, nonatomic)  CardInfoModel *model;
@property (weak, nonatomic)  NSNumber *card_idNum;

@end

@implementation WalletwithdrawalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(48, 46, 58);
    [self getCarddata];
    self.yueLabel.text =[NSString stringWithFormat:@"余额%@", self.price];
    [self.pwview.pwInputView.textField resignFirstResponder];
    self.passInputWordView.center = CGPointMake(ScreenWidth/2, ScreenHeight/2);
    self.pwview.pwInputView.tag=1111;//用于标识密码输入完毕自动触发提现请求
    self.passInputWordView.frame =self.view.bounds;
    self.passInputWordView.hidden = YES;
    [self.view addSubview:self.passInputWordView];
}

//获取银行卡列表
-(void)getCarddata{
    
    [[ServiceForUser manager]postMethodName:@"mobile/member_bank/index" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            NSArray *result =[data objectForKey:@"result"];
            for (int i=0; i<result.count; i++) {
                CardInfoModel *model = [[CardInfoModel alloc]init];
                model.status = [result[i] safeNumberForKey:@"status"];
                model.card_id = [result[i] safeNumberForKey:@"card_id"];
                model.bank_img = [result[i] safeStringForKey:@"bank_img"];
                model.user_name = [result[i] safeStringForKey:@"user_name"];
                model.bank_card = [result[i] safeStringForKey:@"bank_card"];
                model.bank_name = [result[i] safeStringForKey:@"bank_name"];
                [self.cardArray  addObject:model];
            }
            self.model = self.cardArray[0];
            self.card_idNum =self.model.card_id;
            [self setUI];
        }
        else
        {
            [AlertHelper showAlertWithTitle:error];
        }
    }];
    
}

- (IBAction)hiddenAction:(UIButton *)sender {
    [self.pwview.pwInputView clearUpPassword];//取消键盘第一响应
    self.passInputWordView.hidden=YES;
    
}


- (IBAction)selectCardAction:(UIButton *)sender {
    CardBindViewController *carsh =[[CardBindViewController alloc]init];
    carsh.typetag = 101;//判别是从银行卡跳入海时提现
    WEAKSELF
    carsh.selectCardBlodk =^(CardInfoModel *model){
        weakSelf.model = model;
        weakSelf.card_idNum = self.model.card_id;
        [weakSelf setUI];
    };
    
    [self.navigationController pushViewController:carsh animated:YES];
    
}

-(void)setUI{
    [self.cardImageView sd_setImageWithURL:[NSURL URLWithString:self.model.bank_img]];
    self.cardBankNameLabel.text=@"";
    NSString *backName = [self.model.bank_card  substringWithRange:NSMakeRange(self.model.bank_card.length-4,4)] ;
    self.cardBankNameLabel.text =[NSString stringWithFormat:@"%@(%@)",self.model.bank_name,backName];
}


- (IBAction)confirmCarshAction:(UIButton *)sender {
    if(self.amountTextfiled.text.length==0){
        [AlertHelper showAlertWithTitle:@"请先输入提现金额"];
        return;
    }
    
    self.passInputWordView.hidden =NO;
    self.moneyNumberLabel.text =self.amountTextfiled.text;
    [self.pwview.pwInputView.textField becomeFirstResponder];
    self.pwview.pwInputView.el_topToBottom(self.pwview.stringLabel,20).el_rightToSuperView(14).el_leftToSuperView(14).el_toHeight(45);
    
    self.pwview.pwInputView.inputAllBlodk =^(NSString *pwnumber){
        NSString *pwString = pwnumber;
        [self.pwview.pwInputView clearUpPassword];//zyf 改
        [SVProgressHUD show];
        
        NSDictionary *params =@{
                                 @"card_id":self.card_idNum,
                                 @"pdc_amount":@([self.amountTextfiled.text floatValue]),
                                 @"password":@([pwString floatValue])
                                 };
        [[ServiceForUser manager]postMethodName:@"mobile/recharge/pd_cash_add" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            if (status) {
                [self gotoweb];
                self.passInputWordView.hidden =YES;
                self.pwview.pwInputView.textField.text =@"";
                [self.pwview.pwInputView clearUpPassword];
            }
            else
            {
                self.passInputWordView.hidden =YES;
                [self.pwview.pwInputView clearUpPassword];
                [AlertHelper showAlertWithTitle:error];
            }
        }];
    };
}

-(void)gotoweb{
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"提现成功"];
    
    NSInteger dis = 2; //前后的天数
    NSDate*nowDate = [NSDate date];
    NSDate* theDate;
    
    if(dis!=0)
    {
        NSTimeInterval  oneDay = 24*60*60*1;  //1天的长度
        
        theDate = [nowDate initWithTimeIntervalSinceNow: +oneDay*dis ];
        
    }
    else
    {
        theDate = nowDate;
    }
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-ddHH:mm:ss"];
    
    NSString *strDate =[[dateFormatter stringFromDate:theDate] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    CommonUIWebViewController *web = [[CommonUIWebViewController alloc]init];
    NSString *bankName =  [self.model.bank_name stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
      web.address  = [NSString stringWithFormat:@"%@order/progress?cardName=%@&service=1&price=%@&time=%@&key=%@&isBack=true",web_url,bankName,self.amountTextfiled.text,strDate,HTTPClientInstance.token];
    [self.navigationController pushViewController:web animated:YES];
    
    
}
- (IBAction)allTiXianAction:(id)sender {
    self.amountTextfiled.text =[self.price substringFromIndex:1];
}


-(NSMutableArray *)cardArray{
    if (!_cardArray) {
        _cardArray = [NSMutableArray array];
    }
    return _cardArray;
}

@end