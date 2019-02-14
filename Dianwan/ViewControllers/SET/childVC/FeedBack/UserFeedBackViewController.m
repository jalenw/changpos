//
//  UserFeedBackViewController.m
//  0756yc
//
//  Created by LinShaoWei on 15/11/14.
//  Copyright © 2015年 Zeng. All rights reserved.
//

#import "UserFeedBackViewController.h"
#define Str @"请输入您要反馈的问题"
#define MaxCount 200

@interface UserFeedBackViewController ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIButton *submit;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end

@implementation UserFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"反馈意见";
    
    self.view.backgroundColor =RGB(48, 46, 58);
    self.submit.layer.cornerRadius = 21;
    self.submit.layer.masksToBounds = YES;

    
    [self setRightBarButtonWithTitle:@"提交"];
    [self initTextView];
    
    UITapGestureRecognizer *tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];
    tapGr.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tapGr];
    
    self.countLab.text = [NSString stringWithFormat:@"0/%ld",(long)MaxCount];
   
}

-(void)rightbarButtonDidTap:(UIButton *)button
{
     NSString *feedbaackStr =  textview.text;
    [[ServiceForUser manager]postMethodName:@"mobile/memberfeedback/feedback_add" params:@{@"content":feedbaackStr} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
                [AlertHelper showAlertWithTitle:@"提交成功" duration:3];
                [self.navigationController popViewControllerAnimated:YES];
        }
        else
            [AlertHelper showAlertWithTitle:error];
    }];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [IQKeyboardManager sharedManager].enable = NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}



#pragma mark - init初始化
- (void)initTextView{
    textview = [[UITextView alloc] initWithFrame:CGRectMake(20, 20, ScreenWidth-40, 160)];
    textview.backgroundColor=[UIColor whiteColor]; //背景色
    textview.scrollEnabled = YES;    //当文字超过视图的边框时是否允许滑动，默认为“YES”
    textview.editable = YES;        //是否允许编辑内容，默认为“YES”
    textview.delegate = self;       //设置代理方法的实现类
    textview.showsVerticalScrollIndicator = NO;
    textview.font=[UIFont systemFontOfSize:14]; //设置字体名字和字体大小;
    textview.returnKeyType = UIReturnKeyDone;//return键的类型
    textview.keyboardType = UIKeyboardAppearanceDefault;//键盘类型
    textview.textAlignment = NSTextAlignmentLeft; //文本显示的位置默认为居左
    //    textview.dataDetectorTypes = UIDataDetectorTypeAll; //显示数据类型的连接模式（如电话号码、网址、地址等）
    textview.textColor = [UIColor blackColor];
    textview.text = Str;//设置显示的文本内容
    textview.textColor = [UIColor lightGrayColor];
    [self.view addSubview:textview];
}

#pragma mark - TextView Delegate
//开始编辑
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if ([textview.text isEqualToString:Str]) {
        textview.text = @"";
    }
    textview.textColor = [UIColor blackColor];
    isEditText = YES;
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    if([text isEqualToString:@"\n"]){
        HIDE_KEY_BOARD
        return NO;
    }
    return YES;
}

- (void) textViewDidChange:(UITextView *)textView {
    self.countLab.text = [NSString stringWithFormat:@"%ld/%ld",textView.text.length,(long)MaxCount];
}

//结束编辑
- (void)textViewDidEndEditing:(UITextView *)textView{
    //该判断用于联想输入
    if (textView.text.length > MaxCount)
    {
        textView.text = [textView.text substringToIndex:MaxCount];
        self.countLab.text = [NSString stringWithFormat:@"%ld/%ld",(long)MaxCount,(long)MaxCount];
    }
    
    if ([textview.text isEqualToString:@""]) {
        textview.text = Str;
        textview.textColor = [UIColor lightGrayColor];
        isEditText = NO;
    }else{
        textview.textColor = [UIColor blackColor];
    }
}

#pragma mark - 按钮点击事件
- (void)RightBtnclick:(UIButton *)sender {
    HIDE_KEY_BOARD;
    if ([textview.text isEqualToString:@""] || !isEditText) {
        [AlertHelper showAlertWithTitle:@"内容不能为空！" duration:2];
        return;
    }
    [self sendFeedBackData];
}

//- (IBAction)RightBtnclick:(id)sender {
//
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark - 数据处理
- (void)sendFeedBackData{
    HIDE_KEY_BOARD
    [SVProgressHUD show];
    [[ServiceForUser manager]postMethodName:@"" params:@{@"content":textview.text} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            if ([data safeIntForKey:@"code"]==200) {
                NSLog(@"意见反馈成功");
                [AlertHelper showAlertWithTitle:@"提交成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [AlertHelper showAlertWithTitle:[NSString stringWithFormat:@"%@",requestFailed]];
            }
           
        }
        else
            [AlertHelper showAlertWithTitle:error];
    }];
}

#pragma mark - 隐藏键盘
-(void)viewTapped:(UITapGestureRecognizer*)tapGr {
    HIDE_KEY_BOARD
}


@end
