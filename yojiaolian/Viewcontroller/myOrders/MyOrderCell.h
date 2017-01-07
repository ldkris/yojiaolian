//
//  MyOrderCell.h
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyOrdersVC;
@interface MyOrderCell : UITableViewCell
@property(nonatomic,assign)MyOrdersVC *delegate;
@property(nonatomic,assign)IBOutlet UIView *contentBG;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
@property(nonatomic,assign)IBOutlet UILabel *labelLicenseType;
@property(nonatomic,assign)IBOutlet UILabel *labelState;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelTime;
@property(nonatomic,assign)IBOutlet UILabel *labelPrice;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateView;
@end
