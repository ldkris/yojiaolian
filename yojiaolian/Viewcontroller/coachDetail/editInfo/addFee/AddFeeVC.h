//
//  AddFeeVC.h
//  yojiaolian
//
//  Created by carcool on 4/14/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
@class EditInfoVC;
@interface AddFeeVC : YCCViewController<UITextFieldDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property(nonatomic,assign)NSInteger addOrEdit;//0:add 1:edit
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
@property(nonatomic,assign)IBOutlet UIView *lineView2;
@property(nonatomic,assign)IBOutlet UILabel *labelFeeType;
@property(nonatomic,assign)IBOutlet UILabel *labelLicenseType;
@property(nonatomic,assign)IBOutlet UITextField *textfieldFeeName;
@property(nonatomic,assign)IBOutlet UITextField *textfieldFeePrice;
@property(nonatomic,retain)UIPickerView* pickerView ;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)NSMutableArray *m_aryOperate;
@property(nonatomic,assign)EditInfoVC *delegate;
@property(nonatomic,assign)NSInteger feeIndex;
-(void)updateView;
@end
