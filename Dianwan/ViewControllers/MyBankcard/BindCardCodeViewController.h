//
//  BindCardCodeViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/2/18.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"
@protocol BindCardCodeViewControllerDelegate<NSObject>
-(void)codeValDone;
@end
NS_ASSUME_NONNULL_BEGIN

@interface BindCardCodeViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UILabel *words;
@property (assign,nonatomic) id<BindCardCodeViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
