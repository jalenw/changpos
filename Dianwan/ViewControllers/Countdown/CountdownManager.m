//
//  CountdownManager.m
//  appleStore
//
//  Created by LinShaoWei on 2017/5/5.
//  Copyright © 2017年 TestStoryBoard. All rights reserved.
//

#import "CountdownManager.h"

@implementation CountdownManager

- (instancetype)init {
    static dispatch_once_t onceToken;
    static CountdownManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    static CountdownManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)shareManager {
    return [[self alloc] init];
}

#pragma mark - 计时器创建、销毁、更新
- (void)timerStart {
    if (!_timer) {
//        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateUI) userInfo:nil repeats:YES];
        _timer = [NSTimer scheduledTimerWithTimeInterval:1
                                                 target:self
                                               selector:@selector(updateUI)
                                               userInfo:nil
                                                repeats:YES];
        
        [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        [_timer fire];
    }
}

- (void)timerStop {
    if (_timer.valid) {
        [_timer invalidate];
    }
    _timer = nil;
}

- (void)updateUI {
    if ([self changeTime]) {
        [self timerStop];
    }
    if (self.delegate && [self.delegate respondsToSelector:@selector(changeUIWithSec)]) {
        [self.delegate changeUIWithSec];
//        DLog(@"计时器跳动");
    }
}

- (BOOL)changeTime {
    _registTime = _registTime>0?(_registTime-1):0;
    _forgetTime = _forgetTime>0?(_forgetTime-1):0;
    _changePhoneTime = _changePhoneTime>0?(_changePhoneTime-1):0;
    _bindTime = _bindTime>0?(_bindTime-1):0;
    _matchTime = _matchTime>0?(_matchTime-1):0;
    _payPwdTime = _payPwdTime>0?(_payPwdTime-1):0;
    
    
    if (_registTime == 0 &&
        _forgetTime == 0 &&
        _changePhoneTime == 0 &&
        _bindTime ==0 &&
        _matchTime ==0 &&
        _payPwdTime == 0) {
        return YES;
    }else {
        return NO;
    }
}

#pragma mark - 获取时间转化后的文本
- (void)getTimeStringByTime:(NSInteger)time Success:(void (^)(NSInteger day,NSInteger hour,NSInteger min,NSInteger sec))success {
    NSInteger day = floor(time/(60*60*24));
    NSInteger hour = floor((time % (3600*24))/ 3600);
    NSInteger min = floor(((time % (3600*24))%3600)/60);
    NSInteger sec = time%60;
    success(day,hour,min,sec);
}

- (NSString *)getStringByDHMS:(NSInteger)time {
    NSInteger day = floor(time/(60*60*24));
    NSInteger hour = floor((time % (3600*24))/ 3600);
    NSInteger min = floor(((time % (3600*24))%3600)/60);
    NSInteger sec = time%60;
    return [NSString stringWithFormat:@"还剩%ld天%02ld小时%02ld分%02ld秒",day,hour,min,sec];
}

- (NSString *)getStringByTime:(NSInteger)time {
    NSInteger day = floor(time/(60*60*24));
    NSInteger hour = floor((time % (3600*24))/ 3600);
    NSInteger min = floor(((time % (3600*24))%3600)/60);
    NSInteger sec = time%60;
    return [NSString stringWithFormat:@"剩余时间 %02ld:%02ld:%02ld",hour+day*24,min,sec];
}


- (NSString *)getSurpriseNextTime {
    return @"222";
}

@end
