//
//  TruenameView.h
//  Dianwan
//
//  Created by Yang on 2019/1/9.
//  Copyright © 2019 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TruenameView : UIView
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;
@property (weak, nonatomic) IBOutlet UITextField *idCardNumber;
@property (weak, nonatomic) IBOutlet UIButton *foreBtnImage;
@property (weak, nonatomic) IBOutlet UIButton *backBtnImage;
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;
@property(nonatomic,strong)NSString *foreImageUrl;
@property(nonatomic,strong)NSString *backImageUrl;
//@property(nonatomic,copy)void(^BtnenableBlock)(void);
//@property(nonatomic,copy)void(^BackBlock)(void);
@end
