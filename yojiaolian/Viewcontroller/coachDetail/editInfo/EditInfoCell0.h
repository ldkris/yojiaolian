//
//  EditInfoCell0.h
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EditInfoVC;
@interface EditInfoCell0 : UITableViewCell<UITextFieldDelegate>
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
@property(nonatomic,assign)IBOutlet UIView *lineView2;
@property(nonatomic,assign)IBOutlet UIView *lineView3;
@property(nonatomic,assign)IBOutlet UIView *lineView4;
@property(nonatomic,assign)IBOutlet UIView *lineView5;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,assign)IBOutlet UITextField *textfieldName;
@property(nonatomic,assign)IBOutlet UITextField *textfieldMobile;
@property(nonatomic,assign)IBOutlet UITextField *textfieldDriveYear;
@property(nonatomic,assign)IBOutlet UITextField *textfieldSpaceSite;
@property(nonatomic,assign)IBOutlet UILabel *labelLicenseType;
@property(nonatomic,assign)IBOutlet UILabel *labelSchool;
@property(nonatomic,assign)IBOutlet UILabel *labelSpaceLocation;
@property(nonatomic,assign)EditInfoVC *delegate;
-(void)updateView;
@end
