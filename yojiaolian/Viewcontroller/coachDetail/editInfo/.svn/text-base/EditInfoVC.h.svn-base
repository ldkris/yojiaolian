//
//  EditInfoVC.h
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "EditInfoCell0.h"
@interface EditInfoVC : YCCViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)NSMutableDictionary *coachData;
@property(nonatomic,retain)NSMutableArray *m_aryTags;
@property(nonatomic,retain)NSMutableArray *m_aryFees;
@property(nonatomic,retain)EditInfoCell0 *m_cell0;
@property(nonatomic,retain)UIPickerView* pickerView ;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)NSMutableArray *m_aryOperate;
@property(nonatomic,retain)NSMutableArray *m_aryShowed;
@property(nonatomic,assign)IBOutlet UIButton *btnSubmit;
-(void)showMyPhotoVC;
-(void)saveData;
-(void)creatPickerView;
-(void)showSelectSchoolVC;
-(void)showSearchSpaceSiteVC;
-(void)showAddFeeVC;
-(void)showEditFeeVC:(NSInteger)index;
-(void)deleteFeeInfo:(NSInteger)index;
-(void)showAddTagVC;
@end
