//
//  AppDelegate.h
//  yojiaolian
//
//  Created by carcool on 10/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"
#import "myTabbarVC.h"
#import "SettingVC.h"
#import "CoachDetailVC.h"
#import <BaiduMapAPI_Location/BMKLocationService.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearch.h>
#import <BaiduMapAPI_Search/BMKGeocodeSearchOption.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
{
    BMKMapManager* _mapManager;
    BMKLocationService *_locService;
    BMKGeoCodeSearch *_searcher;
}
@property(strong,nonatomic)NSBlockOperation *m_block;
@property(nonatomic,assign)CLLocationCoordinate2D m_currentLocation;
@property(nonatomic,retain)NSString *m_currentAddress;
@property (strong, nonatomic) UIWindow *window;
@property(nonatomic,retain)HomeVC *m_homeVC;
@property(nonatomic,retain)CoachDetailVC *m_coachDetailVC;
@property(retain,nonatomic)myTabbarVC *tabBarController;
@property(nonatomic,assign)BOOL isEnterprise;
-(void)startUpdateLocationWithBlock:(void (^)(void))block;
@end

