//
//  BusinessHandlingViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2019/1/10.
//  Copyright © 2019年 intexh. All rights reserved.
//

#import "BaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface BusinessHandlingViewController : BaseViewController
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *bts;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)menuAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
