//
//  MyPhotosVC.h
//  yojiaolian
//
//  Created by carcool on 12/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "MyPhotoCell0.h"
#import "MyPhotoCell1.h"
@class EditInfoVC;
@interface MyPhotosVC : YCCViewController<ImagePlayerViewDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
@property(nonatomic,retain)NSDictionary *userInfo;
@property(nonatomic,retain)UIView *screenBlackBG;
@property(nonatomic,retain)VIPhotoView *bigView;
@property(nonatomic,retain)MyPhotoCell0 *m_cell0;
@property(nonatomic,retain)MyPhotoCell1 *m_cell1;
@property(nonatomic,retain)ImagePlayerView *imagePlayerView;
@property(nonatomic,retain)NSMutableArray *m_aryPhotos;
@property(nonatomic,retain)IBOutlet UIView *deleteView;
@property(nonatomic,retain)UIImagePickerController *picker;
@property(nonatomic,assign)NSInteger updateType;//0:avatar 1:photo
@property(nonatomic,retain)IBOutlet UIView *editView;
@property(nonatomic,retain)IBOutlet UIView *editView2;
@property(nonatomic,retain)UIView *lineViewWhite0;
@property(nonatomic,retain)UIView *lineViewWhite1;
@property(nonatomic,assign)NSInteger editProgress;
@property(nonatomic,assign)BOOL photoShowing;
@property(nonatomic,retain)UIActionSheet *m_actionSheet;
@property(nonatomic,assign)NSInteger cameraOrAlbum;//0:camera 1:album
@property(nonatomic,assign)EditInfoVC *editInfoVCDelegate;
-(void)updateAvart;
-(void)updatePhoto;
@end
