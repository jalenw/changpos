//
//  MyPartnerViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"
#import "LZHTabScrollViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface MyPartnerViewController : LZHTabScrollViewController
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UITextField *searchTf;

@end

NS_ASSUME_NONNULL_END
