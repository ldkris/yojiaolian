//
//  SettingVC.h
//  yojiaolian
//
//  Created by carcool on 10/28/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface SettingVC : YCCViewController
@property(nonatomic,retain)NSDictionary *data;
-(void)showEditPhotoVC;
-(void)showIntegralDetailVC;
-(void)showAboutUsVC;
-(void)logoutBtnPressed;
-(void)showEditInfoVC;
@end
