//
//  QRShowViewController.m
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/6.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "QRShowViewController.h"

@interface QRShowViewController ()
{
    NSArray *bgList;
    int i;
}
@end

@implementation QRShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的二维码";
    [[ServiceForUser manager]postMethodName:@"mobile/memberinviter/index" params:@{} block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        if (status) {
            self.name.text = [[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"member_name"];
            self.code.text = [[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"inviter_code"];
            [self.headImg sd_setImageWithURL:[NSURL URLWithString:[[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"member_avatar"]]];
            [self.img sd_setImageWithURL:[NSURL URLWithString:[[[data safeDictionaryForKey:@"result"]safeDictionaryForKey:@"info"]safeStringForKey:@"qrcode_url"]]];
            bgList = [[data safeDictionaryForKey:@"result"]safeArrayForKey:@"img_bg_list"];
            NSString *bgUrl = [[bgList objectAtIndex:i] safeStringForKey:@"adv_code"];
            [self.bgImg sd_setImageWithURL:[NSURL URLWithString:bgUrl]];
        }
    }];
    self.moreView.frame = ScreenBounds;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setRightBarButtonWithTitle:@"..."];
}

-(void)rightbarButtonDidTap:(UIButton *)button
{
    if (self.moreView.superview == self.view) {
        [self.moreView removeFromSuperview];
    }
    else
        [self.view addSubview:self.moreView];
}

- (IBAction)disMoreView:(UIButton *)sender {
    [self.moreView removeFromSuperview];
}

- (IBAction)menuAct:(UIButton *)sender {
    [self.moreView removeFromSuperview];
    if (sender.tag==0) {
        if (bgList.count>0) {
            i++;
            if (i==bgList.count) {
                i=0;
            }
            NSString *bgUrl = [[bgList objectAtIndex:i] safeStringForKey:@"adv_code"];
            [self.bgImg sd_setImageWithURL:[NSURL URLWithString:bgUrl]];
        }
    }
    if (sender.tag==1) {
        
    }
    if (sender.tag==2) {
        
    }
    if (sender.tag==3) {
        UIImage *image =  [self nomalSnapshotImage];
        UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"保存相册成功"];
}

- (UIImage *)nomalSnapshotImage
{
    UIGraphicsBeginImageContextWithOptions(self.view.size, NO, [UIScreen mainScreen].scale);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return snapshotImage;
}
@end
