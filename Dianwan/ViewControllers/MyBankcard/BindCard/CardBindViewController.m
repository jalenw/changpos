//
//  CardBindViewController.m
//  BaseProject
//
//  Created by Mac on 2018/10/23.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "CardBindViewController.h"
#import "BindCardOkViewController.h"
#import "RemoveBindCardViewController.h"
#import "CardCellTableViewCell.h"
#import "CardInfoModel.h"
#import "PWInputViewController.h"
#import "UIView+EasyLayout.h"
#import "BindCardOkViewController.h"

@interface CardBindViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *mainTbleview;
@property(nonatomic,strong)NSMutableArray *modelArr;
@property (weak, nonatomic) IBOutlet UIImageView *noCardImageView;
@property (weak, nonatomic) IBOutlet UILabel *noCARDlABEL;
@property (strong, nonatomic) IBOutlet UITableViewCell *addCardCell;
@property (strong, nonatomic)UIImageView *addCard ;
@property (assign, nonatomic)BOOL hascard ;//判断是否已经有绑卡

@end

@implementation CardBindViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
       [self getCardListAction];
    //禁用右滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    [super viewWillAppear:animated];
    [self getCardListAction];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"我的银行卡";
    
    _hascard=NO;
    _modelArr = [NSMutableArray array];
    self.view.backgroundColor = RGB(48, 46, 58);

    _mainTbleview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64-49) style:UITableViewStyleGrouped ];
    _mainTbleview.delegate =self;
    _mainTbleview.dataSource =self;
    _mainTbleview.backgroundColor = RGB(48, 46, 58);
    _mainTbleview.separatorStyle  = UITableViewCellEditingStyleNone;
    [_mainTbleview registerNib:[UINib nibWithNibName:@"CardCellTableViewCell" bundle:nil] forCellReuseIdentifier:@"CardCellTableViewCell"] ;
    [self.view addSubview:_mainTbleview];
    
    _addCard = [[UIImageView alloc]initWithFrame:CGRectMake(50,ScreenHeight -152-64-16, ScreenWidth-100, 52)];
    [_addCard setImage:[UIImage imageNamed:@"tianjyingh_1"]];
    _addCard.userInteractionEnabled =YES;
    UITapGestureRecognizer *addcardTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addCardAction)];
    [_addCard addGestureRecognizer:addcardTap];
    _addCard.contentMode=UIViewContentModeScaleAspectFit;
    _addCard.hidden = YES;
    [self.view addSubview:_addCard];
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //恢复右滑返回
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}


-(void)addCardAction{
    BindCardOkViewController *bindOkVC= [[BindCardOkViewController alloc]init];
    [self.navigationController pushViewController:bindOkVC  animated:YES];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
   return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_hascard){
          return self.modelArr.count +1 ;
    }else{
          return self.modelArr.count ;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_hascard){
        if (indexPath.row==self.modelArr.count) {
            return _addCardCell;
        }else{
        CardCellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CardCellTableViewCell"];
        cell.model =self.modelArr[indexPath.row];
        return cell;
        }
    }else{
        CardCellTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:@"CardCellTableViewCell"];
        cell.model =self.modelArr[indexPath.row];
        return cell;
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      if (indexPath.row==self.modelArr.count) {
             return ScreenWidth *70/375;
      }else{
             return ScreenWidth *121/375;
     }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *head =[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 10)];
    head.backgroundColor = [UIColor clearColor];
    return head;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==self.modelArr.count) {
       
        [self addCardAction];
   
    }else{
        //100为普通跳转
        if(self.typetag==100){
            RemoveBindCardViewController *input =[[RemoveBindCardViewController alloc]init];
            input.model =self.modelArr[indexPath.row];
            [self.navigationController pushViewController:input animated:YES];
        }else{
            _selectCardBlodk(self.modelArr[indexPath.row]);
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

//获取银行卡列表
-(void)getCardListAction{
    
    
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"mobile/member_bank/index" params:@{@"client":@"ios"} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
                NSArray *result =[data objectForKey:@"result"];
                [self.modelArr removeAllObjects];
                
                if(result.count==0){
                    self.mainTbleview.hidden =YES;
                    self.noCARDlABEL.hidden = NO;
                    self.noCardImageView.hidden = NO;
                    self.addCard.hidden =NO;
                    _hascard =NO;
                }else{
                    self.mainTbleview.hidden =NO;
                    self.noCARDlABEL.hidden = YES;
                    self.noCardImageView.hidden = YES;
                    self.addCard.hidden =YES;
                    _hascard =YES;
                }
            
            for (int i=0;i<result.count; i++) {
                CardInfoModel *model =[[CardInfoModel alloc]init];
                model.status = [result[i] safeNumberForKey:@"status"];
                model.card_id = [result[i] safeNumberForKey:@"card_id"];
                model.bank_img = [result[i] safeStringForKey:@"bank_img"];
                model.user_name = [result[i] safeStringForKey:@"user_name"];
                model.bank_card = [result[i] safeStringForKey:@"bank_card"];
                model.bank_name = [result[i] safeStringForKey:@"bank_name"];
                
                [self.modelArr addObject:model];
            }
            [self.mainTbleview reloadData];
        }else{
            [AlertHelper showAlertWithTitle:error];
         }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
