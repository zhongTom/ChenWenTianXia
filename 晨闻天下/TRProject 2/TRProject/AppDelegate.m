//
//  AppDelegate.m
//  TRProject
//
//  Created by jiyingxin on 16/2/4.
//  Copyright © 2016年 Tarena. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+System.h"
#import "PageViewController.h"
#import "TVNetManager.h"
#import "TVViewModel.h"
#import "RadioViewModel.h"
#import "LiveNetManager.h"
#import "TRTabBarController.h"
#import <BmobSDK/Bmob.h>
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
@interface AppDelegate ()
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

    //全局默认配置
    [self setupGlobalConfig];
    [self sideMenue];
    [self bMob];
    [self UMshare];
    return YES;
}

#pragma mark - 方法 Methods
/** 友盟 */
- (void)UMshare{
    [UMSocialData setAppKey:kUMengKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:kWeChatAppId appSecret:kWeChatSecret url:@"http://www.umeng.com/social"];
    //设置手机QQ 的AppId，Appkey，和分享URL，需要#import "UMSocialQQHandler.h"
    [UMSocialQQHandler setQQWithAppId:kQQAppId appKey:kQQAppKey url:@"http://www.umeng.com/social"];
    //打开新浪微博的SSO开关，设置新浪微博回调地址，这里必须要和你在新浪微博后台设置的回调地址一致。需要 #import "UMSocialSinaSSOHandler.h"
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:kSinaAppKey
                                              secret:kSinaAppSecret
                                         RedirectURL:@"http://sns.whalecloud.com/sina2/callback"];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
/** Bmob */
- (void)bMob{
    [Bmob registerWithAppKey:@"354c72c129fcbac20aaae94160c1596f"];
}
- (void)sideMenue{
    id obj = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftMenuViewController"];
    id tab = [TRTabBarController defaultTabBar];
    RESideMenu *sideMenu = [[RESideMenu alloc]initWithContentViewController:tab leftMenuViewController:obj rightMenuViewController:nil];
    self.window.rootViewController = sideMenu;
    sideMenu.scaleContentView = NO;
    sideMenu.contentViewInPortraitOffsetCenterX = 100;
}
@end
