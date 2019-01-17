//
//  SettimngViewController.m
//  BaseProject
//
//  Created by Mac on 2018/10/22.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "SettingViewController.h"
#import "UIView+EasyLayout.h"
#import "ChangeLoginPWViewController.h"
#import "UserFeedBackViewController.h"
#import "PaySetPWViewController.h"
#import "LLFileTool.h"

#define cachePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
@interface SettingViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)UITableView *maintableview;
@property(nonatomic,strong)NSArray *titleArr;
@property (strong, nonatomic)  UILabel *clearLabel;
@property (weak, nonatomic) IBOutlet UIButton *loginoutBtn;
@property (strong, nonatomic) IBOutlet UITableViewCell *loginOutCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *clearCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *changePWCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *paySetCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *feedBackCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *aboutUsCell;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   
    _titleArr = @[_changePWCell,_paySetCell,_clearCell,_feedBackCell,_aboutUsCell];

   self.title =@"设置";
    
    _maintableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 70 * 6) style:UITableViewStyleGrouped];
    self.maintableview.scrollEnabled = NO;
    [self.view addSubview:self.maintableview];
    self.maintableview.delegate =self;
    self.maintableview.dataSource =self;
    self.maintableview.tableFooterView = [[UIView alloc]init];
    self.maintableview.backgroundColor  =RGB(48, 46, 58);
    self.view.backgroundColor  =RGB(48, 46, 58);
    UIButton *btn = [[UIButton alloc]init];
    [self.view addSubview:btn];
    btn.el_topToBottom(self.maintableview,0).el_axisXToAxisX(self.maintableview,0).el_toWidth(250).el_toHeight(50);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:@"退出" forState:UIControlStateNormal ];
    [btn setBackgroundColor:[UIColor colorWithRed:245/255.0 green:183/255.0 blue:56/255.0 alpha:1]];
//    [btn setBackgroundImage:[UIImage imageNamed:@"tcdl_1"] forState:UIControlStateNormal];
    
   [ btn addTarget:self action:@selector(loginOutAction) forControlEvents:UIControlEventTouchUpInside ];
    
    [LLFileTool getFileSize:cachePath completion:^(NSInteger totalSize) {
        self.clearLabel.text = [self cacheSizeStr:totalSize];
        
    }];
    
}

//退出事件
-(void)loginOutAction{
    [AppDelegateInstance logout];
}



#pragma mark --- delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
         return _titleArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
         UITableViewCell *cell =_titleArr[indexPath.row];
        if (indexPath.row == 2 ) {
            self.clearLabel =[[UILabel alloc]initWithFrame: CGRectMake(ScreenWidth-150, 0,115, 70)];
            self.clearLabel.textAlignment = NSTextAlignmentRight;
            self.clearLabel.textColor = [UIColor blackColor];
            [cell addSubview:self.clearLabel];
        }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
     return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
         return 70;
    }

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
            UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 1)];
            view.backgroundColor =[UIColor clearColor];
            return view;
     }

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
        return 0;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        if (indexPath.row==0) {
            ChangeLoginPWViewController *changePW = [[ChangeLoginPWViewController alloc]init];
            changePW.title = @"修改登录密码";
            [self.navigationController pushViewController:changePW animated:YES];
        }else if (indexPath.row==1) {
            PaySetPWViewController *paySetVC = [[PaySetPWViewController alloc]init];
            [self.navigationController pushViewController:paySetVC animated:YES];
        }else if (indexPath.row==2) {
            
            [self clearBtnAction];
        }
        else if (indexPath.row==3) {
            UserFeedBackViewController *feed = [[UserFeedBackViewController alloc]init];
            [self.navigationController pushViewController:feed animated:YES];
        }
}


//计算缓存
- (NSString *)cacheSizeStr:(NSInteger)totalSize {
    NSString *sizeStr = @"";
    if (totalSize > 1000 * 1000) {
        CGFloat sizeF = totalSize / 1000.0 / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fMB)", sizeStr, sizeF];
    } else if (totalSize > 1000) {
        CGFloat sizeF = totalSize / 1000.0;
        sizeStr = [NSString stringWithFormat:@"%@(%.1fKB)", sizeStr, sizeF];
    } else if (totalSize > 0) {
        sizeStr = [NSString stringWithFormat:@"%@(%.ldB)", sizeStr, totalSize];
    }
    return sizeStr;
}

- (void)clearBtnAction {
    [LLFileTool removeDirectoryPath:cachePath];
    self.clearLabel.text =@"0.0M";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [UIApplication sharedApplication].statusBarStyle =  UIStatusBarStyleLightContent;
    
}

@end
