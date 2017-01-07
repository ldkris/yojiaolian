//
//  AppDelegate.m
//  yojiaolian
//
//  Created by carcool on 10/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AppDelegate.h"
#import "HomeVC.h"
#import "APService.h"
#import "MobClick.h"
//share sdk
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKConnector/ShareSDKConnector.h>
//腾讯开放平台（对应QQ和QQ空间）SDK头文件
#import <TencentOpenAPI/TencentOAuth.h>
#import <TencentOpenAPI/QQApiInterface.h>
//微信SDK头文件
#import "WXApi.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize tabBarController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    if (![userdefaults objectForKey:@"grab"])
    {
        [userdefaults setObject:@"0" forKey:@"grab"];
    }
    self.isEnterprise=YES;
    self.m_currentAddress=@"";
    NSLog(@"CFBundleIdentifier :%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]);
    if ([[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] isEqualToString:@"com.yocheche.yojiaolian"])
    {
        self.isEnterprise=YES;
    }
    else
    {
        self.isEnterprise=NO;
    }
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.m_homeVC=[[HomeVC alloc] init];
    self.m_coachDetailVC=[[CoachDetailVC alloc] init];
    //tabbar
    self.tabBarController = [[myTabbarVC alloc] init];
    NSMutableArray *controllers = [NSMutableArray array];
    NSArray *item = [NSArray arrayWithObjects:@"home",@"zhaosheng",@"setting",nil];
    NSInteger count = [item count];
    for (int i = 0; i < count; i++)
    {
        switch (i)
        {
            case 0:
            {
                
                YCCNavigationController *nav=[[YCCNavigationController alloc] initWithRootViewController:self.m_homeVC];
                [controllers addObject:nav];
                
            }
                break;
            case 1:
            {
                
                YCCNavigationController *nav=[[YCCNavigationController alloc] initWithRootViewController:self.m_coachDetailVC];
                [controllers addObject:nav];
                
            }
                break;
            case 2:
            {
                
                YCCNavigationController *nav=[[YCCNavigationController alloc] initWithRootViewController:[[SettingVC alloc] init]];
                [controllers addObject:nav];
                
            }
                break;
            default:
                break;
        }
    }
    tabBarController.viewControllers=controllers;
    self.window.rootViewController=tabBarController;
    [self.window makeKeyAndVisible];
    
    //JPush
    // Required
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //可以添加自定义categories
        [APService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                       UIUserNotificationTypeSound |
                                                       UIUserNotificationTypeAlert)
                                           categories:nil];
    } else {
        //categories 必须为nil
        [APService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                       UIRemoteNotificationTypeSound |
                                                       UIRemoteNotificationTypeAlert)
                                           categories:nil];
    }
    // Required
    [APService setupWithOption:launchOptions];
    
    
//    Class cls = NSClassFromString(@"UMANUtil");
//    SEL deviceIDSelector = @selector(openUDIDString);
//    NSString *deviceID = nil;
//    if(cls && [cls respondsToSelector:deviceIDSelector]){
//        deviceID = [cls performSelector:deviceIDSelector];
//    }
//    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:@{@"oid" : deviceID}
//                                                       options:NSJSONWritingPrettyPrinted
//                                                         error:nil];
//    
//    NSLog(@"%@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    
    //友盟
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    [MobClick startWithAppkey:@"566f7bbae0f55a382e006cc7" reportPolicy:BATCH   channelId:nil];
    
    //baudu mapkit
    //baidu map
    _mapManager = [[BMKMapManager alloc]init];
    NSString *baiduappke=@"";
    if (self.isEnterprise==NO)
    {
        baiduappke=@"vsLLL5ZUGEZ6CDyDzp6UBdXOSBGCSXGX";//appstore
    }
    else
    {
        baiduappke=@"ghiKeMR1pYliP9DiG64up40cLARGjLeA";
    }
    // 如果要关注网络及授权验证事件，请设定     generalDelegate参数
    BOOL ret = [_mapManager start:baiduappke  generalDelegate:nil];//appstore
    if (!ret) {
        NSLog(@"BMKMapManager start failed!");
    }
    else
    {
        NSLog(@"BMKMapManager start seccuss.");
    }
    //location get
    self.m_currentLocation=(CLLocationCoordinate2D){0.0,0.0};
    [self startUpdateLocationWithBlock:^{
        
    }];
    
    //share sdk
    [ShareSDK registerApp:@"11c564fa56d30"
     
          activePlatforms:@[
                            @(SSDKPlatformTypeWechat),
                            @(SSDKPlatformTypeQQ)]
                 onImport:^(SSDKPlatformType platformType)
     {
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }
          onConfiguration:^(SSDKPlatformType platformType, NSMutableDictionary *appInfo)
     {
         
         switch (platformType)
         {
             case SSDKPlatformTypeWechat:
                 [appInfo SSDKSetupWeChatByAppId:@"wx5b13cf946ce98bf6"
                                       appSecret:@"4843be5e8f9651121d68970a7d862c3a"];
                 [ShareSDKConnector connectWeChat:[WXApi class]];
                 break;
             case SSDKPlatformTypeQQ:
                 [appInfo SSDKSetupQQByAppId:@"1104909658"
                                      appKey:@"0NGcPjZpqV7Pxyxg"
                                    authType:SSDKAuthTypeBoth];
                 [ShareSDKConnector connectQQ:[QQApiInterface class] tencentOAuthClass:[TencentOAuth class]];
                 break;
             default:
                 break;
         }
     }];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];

    return YES;
}
-(void)startUpdateLocationWithBlock:(void (^)(void))block
{
    self.m_block=[NSBlockOperation blockOperationWithBlock:block];
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    //启动LocationService
    [_locService startUserLocationService];
}
#pragma mark --------------- push -----------------------
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    // Required
    [APService registerDeviceToken:deviceToken];
}
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    NSLog(@"NSError :%@",error);
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    // Required
    [APService handleRemoteNotification:userInfo];
    
}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    
    // IOS 7 Support Required
    [APService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    [self.m_homeVC viewDidAppear:YES];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#pragma mark ---------- BMKLocationServiceDelegate
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //    NSLog(@"heading is %@",userLocation.heading);
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //发起反向地理编码检索
    self.m_currentLocation= (CLLocationCoordinate2D){userLocation.location.coordinate.latitude, userLocation.location.coordinate.longitude};
    [_locService stopUserLocationService];
    _locService.delegate=nil;
    _locService=nil;
    //upload location
    if ([[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        [self.m_homeVC getUserInfo];
    }
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = self.m_currentLocation;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}
#pragma mark --------- BMKGeoCodeSearch delegate
//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR)
    {
        self.m_currentAddress=result.address;
        _searcher.delegate = nil;
        [_locService stopUserLocationService];
        _locService.delegate=nil;
        
        NSLog(@"self.m_currentAddress :%@",self.m_currentAddress);
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
    [self.m_block start];
}
@end
