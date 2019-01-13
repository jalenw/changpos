//
//  ToolManager.h
//  ZuiHuaSuan
//
//  Created by change on 15/12/25.
//  Copyright © 2015年 change. All rights reserved.
//

#import <Foundation/Foundation.h>

#define TOOL [ToolManager shareTool]

@interface ToolManager : NSObject


+ (instancetype)shareTool;

#pragma mark - 字符串、时间处理
/**
 *  修改label部分字体颜色
 *
 *  @param label   需要修改的label
 *  @param font    label字体
 *  @param range   需要改变颜色的位置
 *  @param vaColor 需要设置的颜色
 */
- (void)ColorLabel:(UILabel *)label Font:(id)font AndRange:(NSRange)range AndColor:(UIColor *)vaColor;

- (NSAttributedString *)LabelWithlineStyle:(NSString *)string;

- (NSString *)encodeURL:(NSString *)string;

- (NSString *)objectTransformToString:(id)Object;

- (id)stringTransformToJSON:(NSString *)string;

- (NSString *)timestampToDate:(double)timestamp DateFormat:(NSString *)DateFormat;

- (NSString *)getMD5:(NSString *)str;

- (NSString *)writeFileToDocumentsWithString:(NSString *)str;

- (NSString *)replaceNum:(long long)num;

-(NSString *)filterHTML:(NSString *)html;

#pragma mark - 渐变色设置
- (CAGradientLayer *)getGradientLayerByFrame:(CGRect)frame;

#pragma mark - tableview 设置

/**
 *  隐藏TableView多余的线
 *
 *  @param tableView 需要隐藏的TableView
 */
- (void)setExtraCellLineHidden: (UITableView *)tableView;

/**
 *  设置TableView线段x轴不从0开始
 *
 *  @param tableview 需要设置的TableView
 */
- (void)SetTableviewSeparator:(UITableView *)tableview;

/**
 *  设置TableView的Cell线段x轴不从0开始
 *
 *  @param cell 需要设置的Cell
 */
- (void)setTableViewCellSeparator:(UITableViewCell *)cell;

#pragma mark - 提示语
/**
 *  通用类型的AlertView（没有delegate）
 *
 *  @param msg 需要提示的内容
 */
- (void)showAlertView:(NSString *)msg;

- (void)showSVProgressHUDView:(NSString *)msg;

#pragma mark - 正则表达式
- (BOOL)isEmpty:(NSString *) str;

//手机格式检测
- (BOOL)isPhone:(NSString *)str;

//身份证检测
- (BOOL)isIdentityCard:(NSString *)identityString;

//输入框只能输入x-X位字母、数字、特殊字符验证
- (BOOL)checkTextMin:(NSInteger)min Max:(NSInteger)max Text:(NSString *)text;

//验证邮箱
- (BOOL)isEmail:(NSString *)str;


#pragma mark - web页面跳转
//type 0:push  1:present
- (void)pushToWebViewVC:(UIViewController *)vc Url:(NSString *)url;
- (void)pushToWebViewVC:(UIViewController *)vc Url:(NSString *)url Title:(NSString *)title;
- (void)pushToWebViewVC:(UIViewController *)vc Url:(NSString *)url Title:(NSString *)title PushBackIsHideTabBar:(BOOL)isShowBar PushType:(NSInteger)tpye;


#pragma mark - 分享
- (void)defaultSahre;
- (void)shareWithTitle:(NSString *)title Text:(NSString *)text Imgae:(id)image Url:(NSString *)url;

#pragma mark - 解析环信数据
- (NSDictionary *)jsonToDicForHY:(NSDictionary *)json;

#pragma mark - 获取当前VC
- (UIViewController *)getCurrentVC;
@end
