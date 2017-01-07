//
//  SearchSchoolVC.h
//  yojiaolian
//
//  Created by carcool on 4/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
@class CityListVC;
@interface SearchSchoolVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,assign)IBOutlet UITextField *textfieldSchool;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSString *levelCode;
@property(nonatomic,assign)CityListVC *delegate;
@property(nonatomic,assign)IBOutlet UIButton *btnSubmit;
@end
