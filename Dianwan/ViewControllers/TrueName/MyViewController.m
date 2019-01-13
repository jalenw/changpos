//
//  MyViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2018/8/1.
//  Copyright © 2018年 intexh. All rights reserved.
//

#import "MyViewController.h"
#import "TrueNameViewController.h"
#import "BusinessHandlingViewController.h"
#import "SettingViewController.h"
#import "SetUserInfoViewController.h"
#import "CardBindViewController.h"
#import "MineHeadView.h"
#import "CertificationSuccessViewController.h"
#import "ChatViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *mainTableView;
@property (weak, nonatomic) IBOutlet MineHeadView *smallHeadView;
@property (weak, nonatomic) IBOutlet UIView *isLoginView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (strong, nonatomic) IBOutlet UITableViewCell *headUserInfoCell;
@property (weak, nonatomic) IBOutlet UIImageView *levelImageView;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
//@property (strong, nonatomic) UserModel *model;
@property (weak, nonatomic) IBOutlet UIButton *bianjiBtn;
@property(nonatomic,strong)NSArray *tableViewArr;
@end

@implementation MyViewController
//跳到登录页面
- (IBAction)loginAction:(UIButton *)sender {
    [AppDelegateInstance logout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    if (AppDelegateInstance.defaultUser!=nil) {
        self.isLoginView.hidden=NO;
        self.loginBtn.hidden =YES;
        [self setUI];
    }else{
        self.isLoginView.hidden=YES;
        self.loginBtn.hidden =NO;
    }
    
    
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"wechat_pay"]];
    self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.delegate =self;
    self.mainTableView.dataSource =self;
    self.mainTableView.tableHeaderView.height = 160;
    
    _tableViewArr = @[@"我的钱包",@"我的库存",@"我的伙伴",@"积分与会员",@"我的银行卡",@"消息中心",@"业务申请",@"实名认证",@"在线客服"];
}



//设置数据
-(void)setUI{
    [self.acoverImageView sd_setImageWithURL:[NSURL URLWithString:AppDelegateInstance.defaultUser.member_avatar]];
    self.nameLabel.text = AppDelegateInstance.defaultUser.truename;
    self.phoneLabel.text =AppDelegateInstance.defaultUser.member_mobile;
    self.IdLabel.text =[NSString stringWithFormat:@"ID:%lld",AppDelegateInstance.defaultUser.member_id];
    self.integralLabel.text =[NSString stringWithFormat:@"%lld",AppDelegateInstance.defaultUser.member_points];
    if (AppDelegateInstance.defaultUser.member_level  ==1) {
        [_levelImageView setImage:[UIImage imageNamed: @"我的_青铜会员-1"]];
        [_bgView setImage:[UIImage imageNamed: @"青铜会员头像框-1"]];
    }else  if(AppDelegateInstance.defaultUser.member_level  ==2) {
        [_levelImageView setImage:[UIImage imageNamed: @"我的_白银会员-1"]];
        [_bgView setImage:[UIImage imageNamed: @"白银会员头像框-1"]];
    }else{
        [_levelImageView setImage:[UIImage imageNamed: @"我的_黄金会员-1"]];
        [_bgView setImage:[UIImage imageNamed: @"黄金会员头像框-1"]];
    }
}

-(void)rightbarButtonDidTap:(UIButton *)button{
    SettingViewController *setVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}




#pragma mark--delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.section == 0){
        _headUserInfoCell.selectionStyle =UITableViewCellSelectionStyleNone;
        return _headUserInfoCell;
    }else{
        static NSString *MineCell = @"MineCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MineCell];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = self.tableViewArr[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return ScreenWidth *113/375;
    }else{
        return 52;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }else{
        return self.tableViewArr.count;
    }
}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
//    headView.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
//    return headView;
//
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 10;
//}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        //设置经黄色线条
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 2)];
        headView.backgroundColor =[UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1];
        return headView;
    }
    
    return nil;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 2;
    }else{
        return 0;
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if (indexPath.section==1) {
        if(indexPath.row==0){
            
        }
        if(indexPath.row==1){
            
        }
        if(indexPath.row==2){
            
        }
        if(indexPath.row==3){
            
        }
        if(indexPath.row==4){
            //我的银行卡
            CardBindViewController *mycard = [[CardBindViewController alloc]init];
            [self.navigationController pushViewController:mycard animated:YES];
        }
        if(indexPath.row==5){
            
        }
        if(indexPath.row==6){
            //业务申请
            BusinessHandlingViewController *  Business = [[BusinessHandlingViewController alloc]init];
            [self.navigationController pushViewController:Business animated:YES];
            
        }
        if(indexPath.row==7){
            //实名认证
            if(AppDelegateInstance.defaultUser.is_approve==1){
                TrueNameViewController *truenameVC = [[TrueNameViewController alloc]init];
                [self.navigationController pushViewController:truenameVC animated:YES];
            }else{
                CertificationSuccessViewController *suc = [[CertificationSuccessViewController alloc]init];
                [self.navigationController pushViewController:suc animated:YES];
            }
          
            
        }
        if(indexPath.row==8){
            NSString *chat_id = [AppDelegateInstance.customerService safeStringForKey:@"chat_id"];
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:chat_id conversationType:eConversationTypeChat];
            [self.navigationController pushViewController:chatController animated:YES];
            
        }
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getuserInfo];
}

- (void)getuserInfo{
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/member/get_member_info" params:nil block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            if([data safeIntForKey:@"code"]==200){
                AppDelegateInstance.defaultUser = [User insertOrReplaceWithDictionary:[data safeDictionaryForKey:@"result"] context:AppDelegateInstance.managedObjectContext];
                [self setUI];
            }else{
                NSLog(@"%@",[NSString stringWithFormat:@"%@",requestFailed]);
            }
        }
        else
            [AlertHelper showAlertWithTitle:error];
    }];
}


- (IBAction)gotoUserInfoVCAction:(UIButton *)sender {
    SetUserInfoViewController *setuserinfo =[[SetUserInfoViewController alloc]init];
    [self.navigationController pushViewController:setuserinfo animated:YES];
}

@end
