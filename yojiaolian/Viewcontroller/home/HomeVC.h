//
//  HomeVC.h
//  yojiaolian
//
//  Created by carcool on 10/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "ImagePlayerView.h"
#import "VIPhotoView.h"
@interface HomeVC : YCCViewController<ImagePlayerViewDelegate>
@property(nonatomic,retain)NSDictionary *userInfo;
@property(nonatomic,retain)NSMutableArray *m_aryMessageCount;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryAdver;
//update version
@property(nonatomic,retain)NSString *trackUrl;
@property(nonatomic,retain)NSString *updateContent;
@property(nonatomic,retain)ImagePlayerView *imagePlayerView;
@property(nonatomic,retain)NSMutableArray *m_aryPhotos;
@property(nonatomic,retain)UIView *screenBlackBG;
@property(nonatomic,retain)VIPhotoView *bigView;
@property(nonatomic,retain)IBOutlet UIView *infoView;
@property(nonatomic,retain)UIButton *btnRemove;
@property(nonatomic,retain)NSDictionary *qrcodeInfo;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)IBOutlet WebImageViewNormal *qrcodeImg;
@property(nonatomic,retain)IBOutlet UILabel *labelName;
@property(nonatomic,retain)IBOutlet UILabel *labelClass;
@property(nonatomic,retain)NSDictionary *homeData;
@property(nonatomic,retain)NSArray *m_aryScrollInfo;
-(void)funcBtnPressed:(NSInteger)index;
-(void)getUserInfo;
-(void)showOrderTrainVC;
-(void)showTrainRecordsListVC;
-(void)showTeachLogVC;
-(void)showStudyTimeVC;
-(void)creatPageScrollview;
-(void)showScreenViewForAvatar:(UIImage *)img;
-(void)showWelcomeVC;
-(void)getMyQRCode;
-(void)creatQRCodeView;
-(void)showIntegralVC;
-(void)showSignInStatisticsVC;
-(void)showAdverInfoVC:(NSString*)adverUrl adverTitle:(NSString*)title shareData:(NSDictionary*)shareData;
-(void)showMyGrabOrederVC;
-(void)showMyOrdersVC;
-(void)showOrderTimeVC;
-(void)showCoachDetail;
-(void)showVoiceIntraduction;
@end
