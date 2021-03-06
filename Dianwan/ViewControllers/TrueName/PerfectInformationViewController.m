//
//  PerfectInformationViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/10.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "HooDatePicker.h"
@interface PerfectInformationViewController() <HooDatePickerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *cityTF;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UIButton *grilBtn;
@property (weak, nonatomic) IBOutlet UIButton *boyBtn;
@property (weak, nonatomic) IBOutlet UITextField *brithdaySelectedTF;
@property (weak, nonatomic) IBOutlet UIButton *brithdaySelectedBtn;
@property (strong, nonatomic) IBOutlet UIView *truenameSuccessView;
@property (strong, nonatomic) IBOutlet UIView *brithdaySelectView;
@property (weak, nonatomic) IBOutlet UIView *brithdayprickView;
@property (strong, nonatomic)HooDatePicker *datePicker;

@end

@implementation PerfectInformationViewController

#pragma mark---子视图的显示与隐藏
- (IBAction)brithdaySelectAction:(UIButton *)sender {
    self.brithdaySelectView.hidden =NO;
    
}


- (IBAction)goBackRootVCAction:(UIButton *)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)renZhengAction:(UIButton *)sender {
    [self.cityTF resignFirstResponder];
    [self.addressTF resignFirstResponder];
    
    [SVProgressHUD show];
    if([Tooles judgeIdentityStringValid:self.idcardNum]){
        NSDictionary * params =  @{
                                   @"truename":self.name,
                                   @"idcard":self.idcardNum,
                                   @"pic_after":self.backimageUrl,
                                   @"pic_before":self.foreimageUrl ,
                                   @"client":@"ios"
                                   };
        [[ServiceForUser manager]postMethodName:@"mobile/member/member_approve" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            if (status) {
                        //认证后提交资料用户信息资料
                    NSDictionary * dict =  @{
                                            @"member_avatar":self.name,
                                               @"evolution_city_id":@"",
                                        @"evolution_city":self.cityTF.text,
                                        @"evolution_address":self.addressTF.text ,
                                            @"client":@"ios"
                                            };
                    [[ServiceForUser manager]postMethodName:@"mobile/member/edit_member_info" params:dict block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
                       [SVProgressHUD dismiss];
                        if (status) {
                            //提示认证成功
                                self.truenameSuccessView.frame =self.view.bounds;
                                self.truenameSuccessView.hidden =NO;
                        }
                        
                    }];
                }else{
                [AlertHelper showAlertWithTitle:[data safeStringForKey:@"message"]];
            }

        }];
    }else{
        [SVProgressHUD dismiss];
        [AlertHelper showAlertWithTitle:@"认证失败"];
    }
    
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title =@"完善资料";
    [self addsubviews];
    self.view.backgroundColor = RGB(48, 46, 58);
    
}
-(void)addsubviews{
    //先创建
    _datePicker = [[HooDatePicker alloc] initWithSuperView:self.brithdayprickView];
    _datePicker.title=@"出生年月";
//    _datePicker.tintColor = [UIColor clearColor];
//    _datePicker.backgroundColor =[UIColor clearColor];
//    _datePicker.headerView.backgroundColor = [UIColor clearColor];
    _datePicker.delegate = self;
    _datePicker.cancelButton.hidden =YES;
    _datePicker.sureButton.hidden =YES;
    _datePicker.datePickerMode = HooDatePickerModeYearAndMonth;
    [_datePicker show];
    [self.view addSubview:self.brithdaySelectView];
    self.brithdaySelectView.frame =self.view.bounds;
    self.brithdaySelectView.hidden =YES;
    _truenameSuccessView.hidden =YES;
    [self.view addSubview:_truenameSuccessView];
    
}
- (IBAction)btnSelectedAct:(UIButton *)sender {
    if(sender.tag==1){
        self.boyBtn.selected = YES;
        self.grilBtn.selected = !self.boyBtn.isSelected;
    }else{
        self.boyBtn.selected = NO;
        self.grilBtn.selected = !self.boyBtn.isSelected;
    }
    
}

- (IBAction)sureBtnclickAct:(UIButton *)sender {
    if ([self respondsToSelector:@selector(datePicker:didSelectedDate:)]) {
    [self datePicker:_datePicker didSelectedDate:[_datePicker getDate]];
    }
}
- (IBAction)cancleBtnclickAct:(UIButton *)sender {
    if ([self respondsToSelector:@selector(datePicker:didCancel:)]) {
        [self datePicker:_datePicker didCancel:sender];
    }
}


//代理，隐藏控件，暂时没有这个字段的接口
- (void)datePicker:(HooDatePicker *)datePicker didCancel:(UIButton *)sender {
     [_datePicker show];
    self.brithdaySelectView.hidden =YES;
}

- (void)datePicker:(HooDatePicker *)datePicker didSelectedDate:(NSDate*)date {
    [_datePicker show];
    //创建一个日期格式化器
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    dateFormatter.dateFormat=@"yyyy-MM";//指定转date得日期格式化形式
    self.brithdaySelectedTF.text =[dateFormatter stringFromDate:date];
    
   self.brithdaySelectView.hidden =YES;
}



@end
