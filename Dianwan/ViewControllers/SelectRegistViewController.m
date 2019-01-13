//
//  SelectRegistViewController.m
//  BaseProject
//
//  Created by Mac on 2018/10/23.
//  Copyright © 2018年 ZNH. All rights reserved.
//

#import "SelectRegistViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
//#import "WCQRCodeVC.h"
#import <AVFoundation/AVFoundation.h>
#import "ZTNavigationController.h"
#import "HMScannerController.h"
@interface SelectRegistViewController ()
@property (weak, nonatomic) IBOutlet UIButton *yaoqingREG;
@property (weak, nonatomic) IBOutlet UIButton *saomaREG;

@property(nonatomic,strong)NSString *RegistMethon;


@end

@implementation SelectRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.view.backgroundColor = RGB(48, 46, 58);
//    self.RegistMethon = @"1";
//    self.saomaREG.selected = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)sweepCodeAction:(UIButton *)sender {
    HMScannerController *scanner = [HMScannerController scannerWithCardName:@"" avatar:@"" completion:^(NSString *stringValue) {

        CommonUIWebViewController *inputPWVC = [[CommonUIWebViewController alloc] init];
        inputPWVC.address =stringValue;
        inputPWVC.showNav = YES;
//        WebViewController *inputPWVC = [[WebViewController alloc]init];
//        inputPWVC.url = stringValue;
        WEAKSELF
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [weakSelf.navigationController pushViewController:inputPWVC animated:YES];
        });
    }];
    
    [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
    
    [self showDetailViewController:scanner sender:nil];
  
}
- (IBAction)InvitationRegisterAction:(UIButton *)sender {
    RegisterViewController *vc = [[RegisterViewController alloc] init];
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    vc.resgiterSuccess = ^(NSString *phone, NSString *password) {
        //                weakSelf.phoneTF.text = phone;
        //                weakSelf.passwordTF.text = password;
        AppDelegateInstance.window.rootViewController = [[LoginViewController alloc]init];
    };
}

- (IBAction)RegistrationWayAction:(UIButton *)sender {
    if([self.RegistMethon isEqualToString:@"1"]){
   
        
        
        HMScannerController *scanner = [HMScannerController scannerWithCardName:@"" avatar:@"" completion:^(NSString *stringValue) {
            
            
            CommonUIWebViewController *inputPWVC = [[CommonUIWebViewController alloc]init];
            inputPWVC.address = stringValue;
            inputPWVC.showNav =YES;
                WEAKSELF
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController pushViewController:inputPWVC animated:YES];
            });
        }];
        
        [scanner setTitleColor:[UIColor whiteColor] tintColor:[UIColor greenColor]];
        
        [self showDetailViewController:scanner sender:nil];
        
        
   
    }else{
            WEAKSELF
            RegisterViewController *vc = [[RegisterViewController alloc] init];
            self.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:vc animated:YES];
//            vc.resgiterSuccess = ^(NSString *phone, NSString *password) {
//                AppDelegateInstance.window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:[[LoginViewController alloc]init]];
//            };
    }
}




- (void)QRCodeScanVC:(UIViewController *)scanVC {
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device) {
        AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
        switch (status) {
            case AVAuthorizationStatusNotDetermined: {
                [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                    if (granted) {
                        dispatch_sync(dispatch_get_main_queue(), ^{
                            [self.navigationController pushViewController:scanVC animated:YES];
                        });
                        NSLog(@"用户第一次同意了访问相机权限 - - %@", [NSThread currentThread]);
                    } else {
                        NSLog(@"用户第一次拒绝了访问相机权限 - - %@", [NSThread currentThread]);
                    }
                }];
                break;
            }
            case AVAuthorizationStatusAuthorized: {
                [self.navigationController pushViewController:scanVC animated:YES];
                break;
            }
            case AVAuthorizationStatusDenied: {
                UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"请去-> [设置 - 隐私 - 相机 - SGQRCodeExample] 打开访问开关" preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
                    
                }];
                
                [alertC addAction:alertA];
                [self presentViewController:alertC animated:YES completion:nil];
                break;
            }
            case AVAuthorizationStatusRestricted: {
                NSLog(@"因为系统原因, 无法访问相册");
                break;
            }
                
            default:
                break;
        }
        return;
    }
    
    UIAlertController *alertC = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"未检测到您的摄像头" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *alertA = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    [alertC addAction:alertA];
    [self presentViewController:alertC animated:YES completion:nil];
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
