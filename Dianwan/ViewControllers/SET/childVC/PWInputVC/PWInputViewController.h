//
//  PWInputViewController.h
//  Dianwan
//
//  Created by Yang on 2019/1/8.
//  Copyright © 2019 intexh. All rights reserved.
//

#import "BaseViewController.h"

@interface PWInputViewController : BaseViewController
//提示文字，是设置，还是支付
@property(nonatomic,strong)NSString * tipsLabelStr;


//判断是哪个页面跳进来的  1--修改支付密码
@property(nonatomic,strong)NSString *Incometype;
//修改密码所需验证码，仅修改设置使用
@property(nonatomic,strong)NSString * codeStr;

@end
