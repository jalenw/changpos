//
//  CountdownManager.h
//  appleStore
//
//  Created by LinShaoWei on 2017/5/5.
//  Copyright © 2017年 TestStoryBoard. All rights reserved.
//

//登录、注册验证码倒计时管理
#import <Foundation/Foundation.h>

@protocol CountdownManagerDelegate <NSObject>

/**
 *  更新UI
 *
 *  
 */
- (void)changeUIWithSec;

@end

@interface CountdownManager : NSObject


+ (instancetype)shareManager;

/**
 *  计时器
 */
@property (retain, nonatomic) NSTimer * timer;
/**
 *  更新UI的Delegate
 */
@property (weak, nonatomic) id<CountdownManagerDelegate> delegate;

/**
 *  计时属性
 */
@property (assign, nonatomic) NSInteger registTime; //注册时间
@property (assign, nonatomic) NSInteger forgetTime; //忘记密码时间
@property (assign, nonatomic) NSInteger changePhoneTime; //修改手机时间
@property (assign, nonatomic) NSInteger bindTime; //绑定手机时间
@property (assign, nonatomic) NSInteger matchTime; //匹配时间
@property (assign, nonatomic) NSInteger payPwdTime; //修改支付密码时间

/**
 *  计时器开始计时
 */
- (void)timerStart;

/**
 *  计时器停止计时
 */
- (void)timerStop;

- (void)getTimeStringByTime:(NSInteger)tiem Success:(void (^)(NSInteger day,NSInteger hour,NSInteger min,NSInteger sec))success;

- (NSString *)getStringByDHMS:(NSInteger)time;

- (NSString *)getStringByTime:(NSInteger)time;
@end

