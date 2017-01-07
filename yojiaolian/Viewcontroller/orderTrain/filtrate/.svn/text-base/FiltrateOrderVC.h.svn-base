//
//  FiltrateOrderVC.h
//  yojiaolian
//
//  Created by carcool on 10/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@protocol FiltrateOrderVCDelegate <NSObject>
-(void)filtrateBtnPressed:(NSDictionary*)dic;
@end

@interface FiltrateOrderVC : YCCViewController<UIPickerViewDataSource,UIPickerViewDelegate,UITextFieldDelegate>
@property(nonatomic,assign)NSInteger type;//3:study statics
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,assign)IBOutlet UIButton *btn;
@property(nonatomic,assign)IBOutlet UIView *itemBG1;
@property(nonatomic,assign)IBOutlet UIView *itemBG2;
@property(nonatomic,assign)IBOutlet UIView *itemBG3;
@property(nonatomic,assign)IBOutlet UIView *itemBG4;
@property(nonatomic,assign)IBOutlet UITextField *textfieldName;
@property(nonatomic,assign)IBOutlet UILabel *labelOperate;
@property(nonatomic,assign)IBOutlet UILabel *labelStartTime;
@property(nonatomic,assign)IBOutlet UILabel *labelEndTime;
@property(nonatomic,retain)UIDatePicker *datePicker;
@property(nonatomic,retain)UIButton *btnPickDone;
@property(nonatomic,retain)UIPickerView* pickerView ;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)NSMutableArray *m_aryOperate;
@property(nonatomic,assign)NSInteger timeType;
@property(nonatomic,assign)id<FiltrateOrderVCDelegate> delegate;

@end
