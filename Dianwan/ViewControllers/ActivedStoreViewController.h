//
//  ActivedStoreViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/20.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"
#import "LZHTabScrollViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ActivedStoreViewController : LZHTabScrollViewController
@property (strong, nonatomic) NSString *others_member_id;
@property (strong, nonatomic) IBOutlet UIView *searchView;
@property (strong,nonatomic)NSString *goods_id;
@property (weak, nonatomic) IBOutlet UITextField *searchTf;
@end

NS_ASSUME_NONNULL_END
