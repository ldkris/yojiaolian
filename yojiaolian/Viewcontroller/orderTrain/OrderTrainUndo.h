//
//  OrderTrainUndo.h
//  yojiaolian
//
//  Created by carcool on 10/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTrainVC;
@interface OrderTrainUndo : UITableViewCell
@property(nonatomic,assign)OrderTrainVC *delegate;
@property(nonatomic,assign)IBOutlet MyButton *btnAgree;
@property(nonatomic,assign)IBOutlet MyButton *btnUnAgree;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
@property(nonatomic,assign)IBOutlet UILabel *labelApplyTime;
@property(nonatomic,assign)IBOutlet UILabel *labelOrderTime;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelPhone;
@property(nonatomic,assign)IBOutlet UILabel *labelOperate;
-(void)updateView;
@end
