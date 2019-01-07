//
//  QRShowViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/6.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface QRShowViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *code;
@property (weak, nonatomic) IBOutlet UIImageView *bgImg;

@end

NS_ASSUME_NONNULL_END
