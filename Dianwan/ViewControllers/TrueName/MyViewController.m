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
#import "MyPartnerViewController.h"
#import "MessageCenterViewController.h"
#import "MyStoreViewController.h"
#import "CreditsAndMembersViewController.h"
#import "MyProfitViewController.h"
@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView *mainTableView;
//@property (weak, nonatomic) IBOutlet MineHeadView *smallHeadView;
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
    self.navigationItem.title = @"我的";
    if (AppDelegateInstance.defaultUser!=nil) {
        self.isLoginView.hidden=NO;
        self.loginBtn.hidden =YES;
        [self setUI];
    }else{
        self.isLoginView.hidden=YES;
        self.loginBtn.hidden =NO;
    }
    
    
    [self setRightBarButtonWithImage:[UIImage imageNamed:@"设置"]];
    if (IS_IPHONE_Xr) {
         self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-88-49) style:UITableViewStylePlain];
    }else{
         self.mainTableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStylePlain];
    }
      self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    [self.view addSubview:self.mainTableView];
    self.view.backgroundColor = RGB(48, 46, 58);
    self.mainTableView.backgroundColor = RGB(48, 46, 58);
    self.mainTableView.delegate =self;
    self.mainTableView.dataSource =self;
    
    _tableViewArr = @[@"我的钱包",@"库存管理",@"渠道管理",@"业务申请",@"我的银行卡",@"消息中心",@"积分与会员",@"实名认证"];
}



//设置数据
-(void)setUI{
    if(AppDelegateInstance.defaultUser.member_avatar.length>0){
          [self.acoverImageView sd_setImageWithURL:[NSURL URLWithString:AppDelegateInstance.defaultUser.member_avatar]];
    }
    self.nameLabel.text = AppDelegateInstance.defaultUser.truename;
    self.phoneLabel.text =AppDelegateInstance.defaultUser.member_mobile;
    self.IdLabel.text =[NSString stringWithFormat:@"ID:%lld",AppDelegateInstance.defaultUser.member_id];
    self.integralLabel.text =[NSString stringWithFormat:@"%lld",AppDelegateInstance.defaultUser.member_points];
//    if (AppDelegateInstance.defaultUser.member_level  ==1) {
        [_levelImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"我的会员%d",AppDelegateInstance.defaultUser.member_level]]];
    
//    }else  if(AppDelegateInstance.defaultUser.member_level  ==2) {
//        [_levelImageView setImage:[UIImage imageNamed: @"byhy_2"]];
//    }else{
//        [_levelImageView setImage:[UIImage imageNamed: @"byhy_3"]];
//    }
}

-(void)rightbarButtonDidTap:(UIButton *)button{
    SettingViewController *setVC = [[SettingViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}




#pragma mark--delegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row == 0){
        _headUserInfoCell.selectionStyle =UITableViewCellSelectionStyleNone;
        return _headUserInfoCell;
    }else{
        static NSString *MineCell = @"MineCell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MineCell];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MineCell];
            UIView *line;
            if(IS_IPHONE_Xr){
                 line = [[UIView alloc]initWithFrame:CGRectMake(0, 61, ScreenWidth, 1)];
            }else{
                 line = [[UIView alloc]initWithFrame:CGRectMake(0, 51, ScreenWidth, 1)];
            }
           
            line.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:line];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.text = self.tableViewArr[indexPath.row-1];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(IS_IPHONE_Xr){
        if(indexPath.row == 0){
            return ScreenWidth *115/375;
        }else{
            return 62;
        }
    }else{
        if(indexPath.row == 0){
            return ScreenWidth *115/375;
        }else{
            return 52;
        }
    }
   
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
        return self.tableViewArr.count+1;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
        if(indexPath.row==0){

        }
        if(indexPath.row==1){
            //
            MyProfitViewController *vc = [[MyProfitViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        if(indexPath.row==2){
            //库存管理
            MyStoreViewController *controller = [[MyStoreViewController alloc] init];
            [self.navigationController pushViewController:controller animated:YES];
        }
        if(indexPath.row==3){
            //渠道管理
            MyPartnerViewController *mypartener =[[MyPartnerViewController alloc]init];
            [self.navigationController pushViewController:mypartener animated:YES];
        }
        if(indexPath.row==4){
            //业务申请
            BusinessHandlingViewController *  Business = [[BusinessHandlingViewController alloc]init];
            [self.navigationController pushViewController:Business animated:YES];
        }
        if(indexPath.row==5){
            //我的银行卡
            CardBindViewController *mycard = [[CardBindViewController alloc]init];
            mycard.typetag=100;//100为普通跳转。zyf
            [self.navigationController pushViewController:mycard animated:YES];
        }
        if(indexPath.row==6){
            //消息中心
            MessageCenterViewController *message =[[MessageCenterViewController alloc]init];
            [self.navigationController pushViewController:message animated:YES];
            
        }
        if(indexPath.row==7){
          //积分与会员
            CreditsAndMembersViewController *credittandmember = [[CreditsAndMembersViewController alloc]init];
            [self.navigationController pushViewController:credittandmember animated:YES];
        }
        if(indexPath.row==8){
            //实名认证
            if(AppDelegateInstance.defaultUser.is_approve==0){
                TrueNameViewController *truenameVC = [[TrueNameViewController alloc]init];
                [self.navigationController pushViewController:truenameVC animated:YES];
            }else{
                CertificationSuccessViewController *suc = [[CertificationSuccessViewController alloc]init];
                [self.navigationController pushViewController:suc animated:YES];
            }
          
            
        }
        if(indexPath.row==9){
            NSString *chat_id = [AppDelegateInstance.customerService safeStringForKey:@"chat_id"];
            ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:chat_id conversationType:eConversationTypeChat];
            [self.navigationController pushViewController:chatController animated:YES];
            
        }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setUI];
}

- (IBAction)gotoUserInfoVCAction:(UIButton *)sender {
    SetUserInfoViewController *setuserinfo =[[SetUserInfoViewController alloc]init];
    [self.navigationController pushViewController:setuserinfo animated:YES];
}

@end
