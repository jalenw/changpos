//
//  SystemDetailViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/18.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SystemDetailViewController : BaseViewController
@property (nonatomic,strong) NSDictionary *dict;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

NS_ASSUME_NONNULL_END
