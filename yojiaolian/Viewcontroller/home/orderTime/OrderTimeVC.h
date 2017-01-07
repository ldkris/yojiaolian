//
//  OrderTimeVC.h
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface OrderTimeVC : YCCViewController<UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryShowed;
@property(nonatomic,retain)NSMutableDictionary *data;
@property(nonatomic,assign)BOOL isFirstTime;
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,retain)UIPickerView* pickerView ;
@property(nonatomic,retain)UIButton *doneBtn;
@property(nonatomic,retain)NSMutableArray *m_aryOperate;
-(void)creatPickerView:(NSInteger)tagIndex;
@end
