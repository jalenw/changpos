//
//  UITableView+Empty.h
//  Dianwan
//
//  Created by 黄哲麟 on 2018/8/3.
//  Copyright © 2018年 intexh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (Empty)
@property (strong,nonatomic)UIImageView *bgView;
-(void)setEmptyView;
-(void)removeEmptyView;
@end
