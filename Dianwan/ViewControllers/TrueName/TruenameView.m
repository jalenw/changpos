//
//  TruenameView.m
//  Dianwan
//
//  Created by Yang on 2019/1/9.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "TruenameView.h"
#import "TZImagePickerController.h"
#import "ZTNavigationController.h"
#import "PerfectInformationViewController.h"

@interface TruenameView ()<UITextFieldDelegate,TZImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *nextstepImageview;

@end
@implementation TruenameView
- (IBAction)nextStepAction:(UIButton *)sender {

    if ([Tooles isEmpty:self.nameTextFiled.text]) {
         [AlertHelper showAlertWithTitle:@"姓名不能为空"];
        return;
    }
    if ([Tooles isEmpty:self.idCardNumber.text]) {
      [AlertHelper showAlertWithTitle:@"身份证号码不能为空"];
        return;
    }
//    if([Tooles judgeIdentityStringValid:self.idCardNumber.text]){
//         [AlertHelper showAlertWithTitle:@"请输入正确的身份证号"];
//         return;
//    }
//    if ([Tooles isEmpty:self.foreImageUrl]) {
//           [AlertHelper showAlertWithTitle:@"请选择一张身份证的正面照"];
//          return;
//    }
//    if ([Tooles isEmpty:self.backImageUrl]) {
//        [AlertHelper showAlertWithTitle:@"请选择一张身份证的背面照"];
//        return;
//    }
    
    
    PerfectInformationViewController *PerfectInformation =[[PerfectInformationViewController alloc]init];
       PerfectInformation.name =self.nameTextFiled.text;
       PerfectInformation.idcardNum =self.idCardNumber.text;
       PerfectInformation.foreimageUrl =self.foreImageUrl;
       PerfectInformation.backimageUrl =self.backImageUrl;
    [[self viewController] pushViewController:PerfectInformation animated:YES];
}


-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.userInteractionEnabled =YES;
        self.backgroundColor = RGB(48, 46, 58);
//        UITapGestureRecognizer *nexttap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(nextStepAction)];
//        [self.nextstepImageview addGestureRecognizer:nexttap];
        
    }
    return self;
}


- (IBAction)uploadicon:(UIButton *)sender {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.showSelectBtn = YES;
    imagePickerVc.allowCrop = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        if (sender.tag==1) {
           [self.foreBtnImage setImage:[photos firstObject] forState:UIControlStateNormal ] ;
        }else{
             [self.backBtnImage setImage:[photos firstObject] forState:UIControlStateNormal];
        }
       
        NSData *imgData = UIImageJPEGRepresentation([photos firstObject], 1);
        [SVProgressHUD show];
        [[ServiceForUser manager] postFileWithActionOp:@"mobile/member/img_upload" andData:imgData andUploadFileName:[Tooles getUploadImageName] andUploadKeyName:@"name" and:@"image/jpeg" params:@{} progress:^(NSProgress *uploadProgress) {
            NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        } block:^(NSDictionary *responseObject, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            if (status) {
//                if([responseObject safeIntForKey:@"code"]==200){
                
                    if (sender.tag==1) {
                        self.foreImageUrl =[responseObject safeStringForKey:@"result"];
                    }else{
                        self.backImageUrl =[responseObject safeStringForKey:@"result"];
                    }
//                }
            }else{
                [AlertHelper showAlertWithTitle:[responseObject safeStringForKey:@"message"]];
            }
        }];
    }];
   [ [self viewController] presentViewController:imagePickerVc animated:YES completion:nil];
}





- ( ZTNavigationController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[ZTNavigationController class]]) {
            return (ZTNavigationController *)nextResponder;
        }
    }
    return nil;
}


@end
