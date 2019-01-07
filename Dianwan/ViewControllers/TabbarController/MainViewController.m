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
    [self addChildVc:[[FirstViewController alloc] init] title:@"首页" image:@"" selectedImage:@""];
    [self addChildVc:[[StatisticViewController alloc] init] title:@"统计" image:@"" selectedImage:@""];
//    EaseConversationListViewController *chatVc = [[EaseConversationListViewController alloc] init];
//    chatVc.delegate = self;
//    [self addChildVc:chatVc title:@"消息" image:@"" selectedImage:@""];
    [self addChildVc:[[QRShowViewController alloc] init] title:@"二维码" image:@"" selectedImage:@""];
    [self addChildVc:[[InformationViewController alloc] init] title:@"资讯" image:@"" selectedImage:@""];
    [self addChildVc:[[MyViewController alloc] init] title:@"我的" image:@"" selectedImage:@""];
    
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
    
    // 设置子控制器的tabBarItem图片
    childVc.tabBarItem.image = [UIImage imageNamed:image];
    // 禁用图片渲染
    childVc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
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
