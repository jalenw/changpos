//
//  FriendsViewController.h
//  Dianwan
//
//  Created by 黄哲麟 on 2017/7/22.
//  Copyright © 2017年 intexh. All rights reserved.
//

#import "BaseViewController.h"

@interface FriendsViewController : BaseViewController
@property(nonatomic,copy) void (^block)(NSDictionary*) ;
@property (nonatomic, strong) NSMutableArray *data;
@end
