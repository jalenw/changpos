//
//  SetUserInfoViewController.m
//  Dianwan
//
//  Created by Yang on 2019/1/10.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "SetUserInfoViewController.h"
#import "TZImagePickerController.h"
#import "CityTableviewViewController.h"
#import "cityModel.h"

@interface SetUserInfoViewController ()<TZImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property(nonatomic,strong)NSString *picurl;
@property(nonatomic,strong)NSString *city_id;
@end

@implementation SetUserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    [self setuserInfoData];
     self.view.backgroundColor = RGB(48, 46, 58);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectedMethon)];
    [self.userAcover addGestureRecognizer:tap];
    
}

-(void)viewWillAppear:(BOOL)animated{
     [super viewWillAppear:animated];
     [self setRightBarButtonWithTitle:@"保存"];
}

- (IBAction)selectCityAction:(UIButton *)sender {
    CityTableviewViewController *cityselect = [[CityTableviewViewController alloc]init];
    WEAKSELF
    cityselect.cityBlock = ^(cityModel * model){
        
        self.cityLabel.text = model.area_name;
        weakSelf.city_id =[NSString stringWithFormat:@"%@", model.area_id];
    };
    [self.navigationController pushViewController:cityselect animated:YES];
    
}


//保存用户信息
-(void)rightbarButtonDidTap:(UIButton *)button{
    if( [Tooles isEmpty:self.cityLabel.text]){
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"地区不能为空"];
        return;
    }
    if([Tooles isEmpty:self.addreLabel.text]){
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"地区不能为空"];
        return;
    }
     [SVProgressHUD show];
    NSDictionary * params =  @{
                               @"member_avatar":self.picurl.length>0?self.picurl:AppDelegateInstance.defaultUser.member_avatar,
                               @"evolution_city":self.cityLabel.text,
                               @"evolution_address":self.addreLabel.text,
                               @"evolution_city_id":self.city_id?self.city_id:[NSString stringWithFormat:@"%lld", AppDelegateInstance.defaultUser.evolution_city_id],
                               };
    [[ServiceForUser manager]postMethodName:@"mobile/member/edit_member_info" params:params block:^(NSDictionary *data, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
            //设置完成后更新信息
            AppDelegateInstance.defaultUser.evolution_city = self.cityLabel.text;
            if (self.city_id) {
                AppDelegateInstance.defaultUser.evolution_city_id = [self.city_id integerValue];
            }
            AppDelegateInstance.defaultUser.evolution_address = self.addreLabel.text;
            if (self.picurl.length>0) {
                AppDelegateInstance.defaultUser.member_avatar = self.picurl;
            }
            [AppDelegateInstance saveContext];
            [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"保存数据成功"];
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [AlertHelper showAlertWithTitle:error];
        }
    }];
}


-(void)selectedMethon{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"头像选择" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
    }];
    
    UIAlertAction *imagelibaray = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self openPhotoLibrary];
    }];
    UIAlertAction *camare = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        [self selectedImageCLickAction];
    }];
    // 添加取消按钮才能点击空白隐藏
    [alertController addAction:cancelAction];
    [alertController addAction:imagelibaray];
    [alertController addAction:camare];
    
    [self presentViewController:alertController animated:YES completion:nil];
    
}

- (void)openPhotoLibrary {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self pushPhotoPickerVc:YES];
    imagePickerVc.allowTakePicture = YES;
    imagePickerVc.allowPickingOriginalPhoto = YES;
    imagePickerVc.showSelectBtn = NO;
    imagePickerVc.allowCrop = YES;
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {

        [self.userAcover setImage:[photos firstObject]];
        NSData *imgData = UIImageJPEGRepresentation([photos firstObject], 1);
        [SVProgressHUD show];
        [[ServiceForUser manager] postFileWithActionOp:@"mobile/member/img_upload" andData:imgData andUploadFileName:[Tooles getUploadImageName] andUploadKeyName:@"name" and:@"image/jpeg" params:@{} progress:^(NSProgress *uploadProgress) {
            NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
        } block:^(NSDictionary *responseObject, NSString *error, BOOL status, NSError *requestFailed) {
            [SVProgressHUD dismiss];
            if (status) {
//                if([responseObject safeIntForKey:@"code"]==200){
                   _picurl =[responseObject safeStringForKey:@"result"];
                  
//                }
            }else{
                [AlertHelper showAlertWithTitle:[responseObject safeStringForKey:@"message"]];
            }
        }];
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}




-(void)selectedImageCLickAction{
    
    // 打开系统相机拍照
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied)
    {
        
        [SVProgressHUD showImage:[UIImage imageNamed:@""] status:@"请先打开摄像机权限"];
        //        [AppDelegate showAlert:self title:nil message:@"您没有相机使用权限,请到设置->隐私中开启权限" okTitle:@"确定" cancelTitle:nil ok:nil cancel:nil];
        return;
    }
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        UIImagePickerController *cameraIPC = [[UIImagePickerController alloc] init];
        cameraIPC.delegate = self;
        cameraIPC.allowsEditing = YES;
        cameraIPC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:cameraIPC animated:YES completion:nil];
        return;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = info[UIImagePickerControllerEditedImage];
    UIImage *cutImage = [self cutImage:image];
    self.userAcover.contentMode =UIViewContentModeScaleAspectFit;
    [self.userAcover setImage:cutImage];
    NSData *imgData = UIImageJPEGRepresentation(image, 1);
    [SVProgressHUD show];
    [[ServiceForUser manager] postFileWithActionOp:@"mobile/member/img_upload" andData:imgData andUploadFileName:[Tooles getUploadImageName] andUploadKeyName:@"name" and:@"image/jpeg" params:@{} progress:^(NSProgress *uploadProgress) {
        NSLog(@"%f",1.0 * uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } block:^(NSDictionary *responseObject, NSString *error, BOOL status, NSError *requestFailed) {
        [SVProgressHUD dismiss];
        if (status) {
//            if([responseObject safeIntForKey:@"code"]==200){
                _picurl =[responseObject safeStringForKey:@"result"];
                
//            }
        }else{
            [AlertHelper showAlertWithTitle:[responseObject safeStringForKey:@"message"]];
        }
    }];
    //如果是相机拍照，则保存到相册
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
    }
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 图片剪裁

- (CGSize)publishSize
{
    CGRect selfRect = self.view.frame;
    return CGSizeMake(selfRect.size.width, selfRect.size.width);//(NSInteger)(selfRect.size.width * 0.618));
}

- (UIImage *)cutImage:(UIImage *)image
{
    CGSize pubSize = [self publishSize];
    if (image)
    {
        CGSize imgSize = image.size;
        CGFloat pubRation = pubSize.height / pubSize.width;
        CGFloat imgRatio = imgSize.height / imgSize.width;
        if (fabs(imgRatio -  pubRation) < 0.01)
        {
            // 直接上传
            return image;
        }
        else
        {
            if (imgRatio > 1)
            {
                // 长图，截正中间部份
                CGSize upSize = CGSizeMake(imgSize.width, (NSInteger)(imgSize.width * pubRation));
                UIImage *upimg = [self cropImage:image inRect:CGRectMake(0, (image.size.height - upSize.height)/2, upSize.width, upSize.height)];
                return upimg;
            }
            else
            {
                // 宽图，截正中间部份
                CGSize upSize = CGSizeMake(imgSize.height, (NSInteger)(imgSize.height * pubRation));
                UIImage *upimg = [self cropImage:image inRect:CGRectMake((image.size.width - upSize.width)/2, 0, upSize.width, upSize.height)];
                return upimg;
            }
        }
    }
    return image;
}

- (UIImage *)cropImage:(UIImage *)image inRect:(CGRect)rect
{
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGRect drawRect = CGRectMake(-rect.origin.x, -rect.origin.y, image.size.width, image.size.height);
    
    CGContextClipToRect(context, CGRectMake(0, 0, rect.size.width, rect.size.height));
    
    
    [image drawInRect:drawRect];
    
    
    UIImage* croppedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return croppedImage;
}

-(void)setuserInfoData{
    [self.userAcover sd_setImageWithURL:[NSURL URLWithString:AppDelegateInstance.defaultUser.member_avatar]];
    self.nameLabel.text = AppDelegateInstance.defaultUser.truename;
    self.ageLabel.text = [NSString stringWithFormat:@"%@",AppDelegateInstance.defaultUser.age];
    self.sexLabel.text = [NSString stringWithFormat:@"%@",AppDelegateInstance.defaultUser.sex];
    self.cityLabel.text = AppDelegateInstance.defaultUser.evolution_city;
    self.idCardLabel.text =AppDelegateInstance.defaultUser.idcard;
    
    self.addreLabel.text = AppDelegateInstance.defaultUser.evolution_address;
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
