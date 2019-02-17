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
@property (weak, nonatomic) IBOutlet UILabel *feilvChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *CompanyLabel;
@property (weak, nonatomic) IBOutlet UILabel *machineNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *machineModeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeRateLabel;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titlelLabel;
@property (weak, nonatomic) IBOutlet UIButton *agressBtn;
@property (weak, nonatomic) IBOutlet UIButton *disagressBtn;
@property (weak, nonatomic) IBOutlet UIView *feilvChanggeView;
@property (weak, nonatomic) IBOutlet UILabel *rateChangeLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (strong, nonatomic) IBOutlet UIView *diaoBoSelectView;
@property(nonatomic,assign)int isJujue;

@end

@implementation ApplyShowDetailViewController

- (IBAction)dealApplyAction:(UIButton *)sender {
    if(sender.tag==1){
         self.isJujue=1;
         self.tipLabel.text =@"确定同意调拨";
    }else{
         self.isJujue=2;
         self.tipLabel.text =@"确定拒绝调拨";
    }
     self.diaoBoSelectView.hidden =NO;

}

- (IBAction)diaoBoAct:(UIButton *)sender {
    if(sender.tag==2){//取消
        self.diaoBoSelectView.hidden=YES;
        return;
    }
    [[ServiceForUser manager]postMethodName:@"mobile/Mystock/parentExamine" params:@{@"id":@(self.idNum),@"type":@(self.isJujue)} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
            self.diaoBoSelectView.hidden=YES;
            if (status) {
                self.agressBtn.hidden =YES;
                self.disagressBtn.hidden =YES;
                [AlertHelper showAlertWithTitle:[data safeStringForKey:@"result"] duration:3];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [AlertHelper showAlertWithTitle:error];
            }
            
        }];
    }


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
}



-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
 
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"申请详情";
    self.diaoBoSelectView.frame = [UIScreen mainScreen].bounds;
    self.diaoBoSelectView.hidden =YES;
    [self.view addSubview:self.diaoBoSelectView];
//    [self setupNav];
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
    //判断是否出现审核按钮
    if ([dict safeIntForKey:@"is_type"]==1&&[[dict safeStringForKey:@"examine_type"] integerValue]==0 ) {
        self.agressBtn.hidden =NO;
        self.disagressBtn.hidden =NO;
    }
    self.titlelLabel.text =[dict safeStringForKey:@"title"];
    self.nameLabel.text =[dict safeStringForKey:@"member_name"];
//    self.phoneNumLabel.text =[dict safeStringForKey:@"member_mobile"];
    self.CompanyLabel.text =[dict safeStringForKey:@"gc_name"];
    switch ([[dict safeStringForKey:@"examine_type"] integerValue]) {
        case 0:
            self.stateLabel.text = @"待上级审核 ";
            self.stateLabel.textColor = RGB(230, 185, 55);
            break;
        case 1:
            
            self.stateLabel.text = @"待平台审核 ";
            self.stateLabel.textColor = RGB(230, 185, 55);
            break;
        case 2:
            
            self.stateLabel.text = @"审核通过 ";
            self.stateLabel.textColor = RGB(230, 185, 55);
            break;
        case 3:
            
            self.stateLabel.text = @"审核失败 ";
              self.stateLabel.textColor = RGB(190, 0, 0);
            break;
            
    }
    self.machineNameLabel.text =[dict safeStringForKey:@"goods_name"];
    self.machineModeLabel.text =[dict safeStringForKey:@"goods_serial"];
    
//    if ([Tooles sizeWithFont:[UIFont systemFontOfSize:17.0] maxSize:CGSizeMake( ScreenWidth-60, MAXFLOAT) string:[dict safeStringForKey:@"decoration"]].height >40 ) {
//        CGRect frame =self.feilvChangeLabel.frame ;
//        frame.origin.y = 0;
//        frame.size.height = 18;
//        self.feilvChangeLabel.frame = frame;// =CGRectMake(15, 0, 70, 40);
//        [self.feilvChanggeView layoutIfNeeded];
//    }
    self.changeRateLabel.text =[dict safeStringForKey:@"decoration"];
  
}


@end
