//
//  CoachDetailVC.h
//  yojiaolian
//
//  Created by carcool on 4/7/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface CoachDetailVC : YCCViewController
@property(nonatomic,assign)BOOL isNeedUploadInfo;
@property(nonatomic,assign)BOOL haveCoachInfo;
@property(nonatomic,assign)BOOL haveCheckInfo;
@property(nonatomic,retain)NSDictionary *coachData;
@property(nonatomic,retain)NSDictionary *shareNoteData;
@property(nonatomic,retain)NSMutableArray *m_aryFees;
@property(nonatomic,retain)NSMutableArray *m_aryTags;
@property(nonatomic,retain)NSMutableArray *m_aryShowed;
@property(nonatomic,retain)IBOutlet UIView *noteShareView;
@property(nonatomic,assign)IBOutlet UILabel *labelGoodNum;
@property(nonatomic,assign)IBOutlet UILabel *labelDefeat;
@property(nonatomic,retain)IBOutlet UIView *noteClickGoodView;
@property(nonatomic,assign)BOOL haveShowedNoteShare;
@property(nonatomic,assign)NSInteger shareFromNote;//0:righttop 1:notecard
@end
