//
//  SearchSpaceSiteVC.h
//  yojiaolian
//
//  Created by carcool on 4/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
@class EditInfoVC;
@interface SearchSpaceSiteVC : YCCViewController<UITextFieldDelegate>
@property(nonatomic,assign)IBOutlet UITextField *textfieldSpace;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSString *cityCode;
@property(nonatomic,assign)EditInfoVC *delegate;
@end
