//
//  ToolManager.m
//  ZuiHuaSuan
//
//  Created by change on 15/12/25.
//  Copyright © 2015年 change. All rights reserved.
//

#import "ToolManager.h"
#import <CommonCrypto/CommonDigest.h>

@implementation ToolManager

- (instancetype)init {
    static dispatch_once_t onceToken;
    static ToolManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [super init];
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    static ToolManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (instancetype)shareTool {
    return [[self alloc] init];
}


//设置不同字体颜色
- (void)ColorLabel:(UILabel *)label Font:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor {
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:label.text];
    //设置字号
    [str addAttribute:NSFontAttributeName value:font range:range];
    //设置文字颜色
    [str addAttribute:NSForegroundColorAttributeName value:vaColor range:range];
    label.attributedText = str;
}

- (NSAttributedString *)LabelWithlineStyle:(NSString *)string {
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:string];
    [attributedString addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, attributedString.length)];
    return attributedString;
}

- (NSString *)encodeURL:(NSString *)string
{
    NSString *newString = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes( kCFAllocatorDefault, (CFStringRef)string, NULL, CFSTR(":/?#[]@!$ &'()*+,;=\"<>%{}|\\^~`"),kCFStringEncodingUTF8));
    if (newString) {
        return newString;
    }
    return @"";
}

- (NSString *)objectTransformToString:(id)Object {
    //转jsonData
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:Object options:0 error:0];
    //jsonData转String
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return jsonStr;
}

- (id)stringTransformToJSON:(NSString *)string {
    NSData * JSONData = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:JSONData
                                                    options:NSJSONReadingAllowFragments
                                                      error:&error];
    if (jsonObject != nil && error == nil) {
        return jsonObject;
    } else {
        // 解析错误
        return nil;
    }
}

- (NSString *)timestampToDate:(double)timestamp DateFormat:(NSString *)DateFormat {
    NSTimeInterval time = timestamp/1000.0f;
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DateFormat];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr;
}


- (NSString *)getMD5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

- (NSString *)writeFileToDocumentsWithString:(NSString *)str {
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    //定义记录文件全名以及路径的字符串filePath
    NSString *filePath = [documentDirectory stringByAppendingPathComponent:@"goodDescription.html"];
    
    //查找文件，如果不存在，就创建一个文件
    if (![fileManager fileExistsAtPath:filePath]) {
        [fileManager createFileAtPath:filePath contents:nil attributes:nil];
    } else {
        NSError *error;
        [fileManager removeItemAtPath:filePath error:&error];
        if (!error) {
            [fileManager createFileAtPath:filePath contents:nil attributes:nil];
        }
    }
    //内容写入文件
    [str writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    return filePath;
}

- (NSString *)replaceNum:(long long)num{
    NSString *titleString = nil;
    
    if (num >= 10000) { // 上万
        CGFloat final = num / 10000.0;
        titleString = [NSString stringWithFormat:@"%.1f万", final];
        // 替换.0为空串
        titleString = [titleString stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (num >= 0) { // 一万以内
        titleString = [NSString stringWithFormat:@"%lld", num];
    }
    
    return titleString;
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];
    }
    return html;
}

#pragma 隐藏多余得分割线
- (void)setExtraCellLineHidden: (UITableView *)tableView {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
}

#pragma mark - 渐变色设置
- (CAGradientLayer *)getGradientLayerByFrame:(CGRect)frame {
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.colors = @[(__bridge id)RGBA_COLOR(112,165,247,1).CGColor, (__bridge id)RGBA_COLOR(40,178,255,1).CGColor, (__bridge id)RGBA_COLOR(63,204,254,1).CGColor];
//    gradientLayer.locations = @[@0.1, @0.5, @1.0];
//    gradientLayer.startPoint = CGPointMake(0, 0);
//    gradientLayer.endPoint = CGPointMake(1.0, 0);
//    gradientLayer.frame = frame;
    return gradientLayer;
}

#pragma mark - 设置TableViewSeparator
- (void)SetTableviewSeparator:(UITableView *)tableview {
    if ([tableview respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableview setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([tableview respondsToSelector:@selector(setLayoutMargins:)]) {
        [tableview setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)setTableViewCellSeparator:(UITableViewCell *)cell {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - 提示框
- (void)showAlertView:(NSString *)msg {
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"提示", nil) message:msg delegate:nil cancelButtonTitle:NSLocalizedString(@"确认", nil) otherButtonTitles:nil];
    [alert show];
}

- (void)showSVProgressHUDView:(NSString *)msg {
    [SVProgressHUD showImage:nil status:msg];
}

#pragma mark - 正则表达式
- (BOOL)isEmpty:(NSString *) str {
    if (!str) {
        return true;
    } else {
        NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSString *trimedString = [str stringByTrimmingCharactersInSet:set];
        if ([trimedString length] == 0) {
            return true;
        } else {
            return false;
        }
    }
}

- (BOOL)isPhone:(NSString *)str {
//    NSString *MOBILE = @"^1([358][0-9]|4[579]|66|7[0135678]|9[89])[0-9]{8}$";
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
//    return [regextestmobile evaluateWithObject:str];
//
    NSString * MOBILE = @"^(13[0-9]|14[579]|15[0-3,5-9]|16[6]|17[0135678]|18[0-9]|19[89])\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    if ([regextestmobile evaluateWithObject:str] == YES) {
        return YES;
    } else {
        return NO;
    }
}

//身份证检测
- (BOOL)isIdentityCard:(NSString *)identityString {
    if (identityString.length != 18){
        return NO;
    }
    
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex  = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum      += subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

//输入框只能输入x-X位字母、数字、特殊字符验证
- (BOOL)checkTextMin:(NSInteger)min Max:(NSInteger)max Text:(NSString *)text {
    NSString *MOBILE = [NSString stringWithFormat:@"^[a-zA-Z0-9\\W]{%ld,%ld}$",min,max];
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return ![regextestmobile evaluateWithObject:text];
}

//验证邮箱
- (BOOL)isEmail:(NSString *)str {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailPre evaluateWithObject:str];
}




#pragma mark - 解析环信数据
- (NSDictionary *)jsonToDicForHY:(NSDictionary *)json {
    if (!json) {
        return nil;
    }
    id result = [json objectForKey:@"ext"];
    result != nil && result != [NSNull null]? result : @"";
    NSString *ext = result;
    NSError* jsonError = nil;
    NSString *messageText = ext;
    if (jsonError) {
        return nil;
    }
    NSDictionary* xmppMessage = [NSJSONSerialization JSONObjectWithData:[messageText dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableLeaves error:&jsonError];
    return xmppMessage;
}


#pragma mark - 获取当前VC
- (UIViewController *)getCurrentVC {
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    UIViewController *currentVC = [self getCurrentVCFrom:rootViewController];
    return currentVC;
}

- (UIViewController *)getCurrentVCFrom:(UIViewController *)rootVC {
    UIViewController *currentVC;
    if ([rootVC presentedViewController]) {
        // 视图是被presented出来的
        rootVC = [rootVC presentedViewController];
    }
    if ([rootVC isKindOfClass:[UITabBarController class]]) {
        // 根视图为UITabBarController
        currentVC = [self getCurrentVCFrom:[(UITabBarController *)rootVC selectedViewController]];
    } else if ([rootVC isKindOfClass:[UINavigationController class]]){
        // 根视图为UINavigationController
        currentVC = [self getCurrentVCFrom:[(UINavigationController *)rootVC visibleViewController]];
    } else {
        // 根视图为非导航类
        currentVC = rootVC;
    }
    return currentVC;
}


@end
