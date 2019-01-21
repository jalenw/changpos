//
//  MainViewController.m
//  SinaWeibo
//
//  Created by user on 15/10/13.
//  Copyright © 2015年 ZT. All rights reserved.
//

#import "MainViewController.h"
#import "ZTNavigationController.h"
#import "ZTTabBar.h"
#import "FirstViewController.h"
#import "MyViewController.h"
#import "EaseConversationListViewController.h"
#import "ChatViewController.h"
#import "InformationViewController.h"
#import "QRShowViewController.h"
#import "StatisticViewController.h"
@interface MainViewController ()<IChatManagerDelegate,EaseConversationListViewControllerDelegate>
{
    NSInteger unreadMessageCount;
}
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addChildVc:[[FirstViewController alloc] init] title:@"" image:@"sytub" selectedImage:@"sytub_1"];
    [self addChildVc:[[StatisticViewController alloc] init] title:@"" image:@"tjtub" selectedImage:@"tjtub_1"];
//    EaseConversationListViewController *chatVc = [[EaseConversationListViewController alloc] init];
//    chatVc.delegate = self;
//    [self addChildVc:chatVc title:@"消息" image:@"" selectedImage:@""];
    [self addChildVc:[[QRShowViewController alloc] init] title:@"" image:@"ewmjtub" selectedImage:@"ewmjtub_1"];
    [self addChildVc:[[InformationViewController alloc] init] title:@"" image:@"zxtub" selectedImage:@"zxtub_1"];
    [self addChildVc:[[MyViewController alloc] init] title:@"" image:@"wdtub" selectedImage:@"wdtub_1"];
    
//   tabbar中间按钮
//    ZTTabBar *tabBar = [[ZTTabBar alloc] init];
//    tabBar.backgroundImage = [Tooles createImageWithColor:RGB(25, 31, 40)];
//    tabBar.delegate = self;
//    tabBar.shadowImage = [Tooles createImageWithColor:RGB(25, 31, 40)];
//    [self setValue:tabBar forKey:@"tabBar"];

    AppDelegateInstance.currentNavigationController =  self.childViewControllers[0];
    
     [self registerNotifications];
}

/**
 *  添加一个子控制器
 *
 *  @param childVc       子控制器
 *  @param title         标题
 *  @param image         图片
 *  @param selectedImage 选中的图片
 */
- (void)addChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置子控制器的文字(可以设置tabBar和navigationBar的文字)
    childVc.title = title;
    
    childVc.tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0);
    // 设置子控制器的tabBarItem图片
    UIImage *t = [self createNewImageWithColor:[UIImage imageNamed:image] multiple:0.5];
    childVc.tabBarItem.image = [t imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] ;
    // 禁用图片渲染
    UIImage *t2 = [self createNewImageWithColor:[UIImage imageNamed:selectedImage] multiple:0.5];
    childVc.tabBarItem.selectedImage = [t2 imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // 设置文字的样式
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : RGB(123, 123, 123)} forState:UIControlStateNormal];
    
    [childVc.tabBarItem setTitleTextAttributes:@{UITextAttributeFont:[UIFont systemFontOfSize:10]} forState:UIControlStateNormal];
    [childVc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : ThemeColor} forState:UIControlStateSelected];
    
    UIOffset offset;
    offset.horizontal = 0.0;
    offset.vertical = 0.0;    [childVc.tabBarItem setTitlePositionAdjustment:offset];

    // 为子控制器包装导航控制器
    ZTNavigationController *navigationVc = [[ZTNavigationController alloc] initWithRootViewController:childVc];
    // 添加子控制器
    [self addChildViewController:navigationVc];
}

- (UIImage *) createNewImageWithColor:(UIImage *)image multiple:(CGFloat)multiple
{
    CGFloat newMultiple = multiple;
    if (multiple == 0) {
        newMultiple = 1;
    }
    else if((fabs(multiple) > 0 && fabs(multiple) < 1) || (fabs(multiple)>1 && fabs(multiple)<2))
    {
        newMultiple = multiple;
    }
    else
    {
        newMultiple = 1;
    }
    CGFloat w = image.size.width*newMultiple;
    CGFloat h = image.size.height*newMultiple;
    CGFloat scale = [UIScreen mainScreen].scale;
    UIImage *tempImage = nil;
    CGRect imageFrame = CGRectMake(0, 0, w, h);
    UIGraphicsBeginImageContextWithOptions(imageFrame.size, NO, scale);
    [[UIBezierPath bezierPathWithRoundedRect:imageFrame cornerRadius:0] addClip];
    [image drawInRect:imageFrame];
    tempImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return tempImage;
}

#pragma ZTTabBarDelegate
/**
 *  中间按钮点击
 */
- (void)tabBarDidClickPlusButton:(ZTTabBar *)tabBar
{

}

-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    NSInteger index = [tabBar.items indexOfObject:item];
    AppDelegateInstance.currentNavigationController =  self.childViewControllers[index];
}

- (void)dealloc
{
    [self unregisterNotifications];
}

-(void)registerNotifications
{
    [self unregisterNotifications];
    [[EaseMob sharedInstance].chatManager addDelegate:self delegateQueue:nil];
}

-(void)unregisterNotifications
{
    [[EaseMob sharedInstance].chatManager removeDelegate:self];
}

-(void)didReceiveMessage:(EMMessage *)message
{
}

//跳转到环信聊天界面
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        if (conversation) {
           NSDictionary *dict = [Tooles stringToJson:[conversation.latestMessage.ext safeStringForKey:@"ext"]];
                ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
                chatController.title = @"";
                [AppDelegateInstance.currentNavigationController pushViewController:chatController animated:YES];
        }
    }
}

@end
