//
//  OrderTrainDetailCell.h
//  yojiaolian
//
//  Created by carcool on 10/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderTrainDetailVC.h"
@interface OrderTrainDetailCell : UITableViewCell
@property(nonatomic,assign)OrderTrainDetailVC *delegate;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
@property(nonatomic,assign)IBOutlet UIView *lineView2;
@property(nonatomic,assign)IBOutlet UIView *lineView3;
@property(nonatomic,assign)IBOutlet UIView *lineView4;
@property(nonatomic,assign)IBOutlet UIView *lineView5;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,assign)IBOutlet UILabel *labelStatus;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelPhone;
@property(nonatomic,assign)IBOutlet UILabel *labelClass;
@property(nonatomic,assign)IBOutlet UILabel *labelTime;
@property(nonatomic,assign)IBOutlet UILabel *labelDate;
@property(nonatomic,assign)IBOutlet UILabel *labelApplyTime;
@property(nonatomic,retain)IBOutlet UILabel *labelReason;
@property(nonatomic,assign)IBOutlet UILabel *labelRefuse;
-(void)updateView;

@end
