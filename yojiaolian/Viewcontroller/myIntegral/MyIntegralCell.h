//
//  MyIntegralCell.h
//  yojiaolian
//
//  Created by carcool on 12/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyIntegralVC.h"
@interface MyIntegralCell : UITableViewCell
@property(nonatomic,assign)MyIntegralVC *delegate;
@property(nonatomic,assign)IBOutlet MyButton *btnExchange;
@property(nonatomic,assign)IBOutlet MyButton *btnMyTicket;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UIView *lineView1;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UILabel *labelTotal;
@property(nonatomic,assign)IBOutlet UILabel *labelAble;
@property(nonatomic,assign)IBOutlet UILabel *labelDisale;
@property(nonatomic,assign)IBOutlet UILabel *labelActivity1;
@property(nonatomic,assign)IBOutlet UILabel *labelActivity2;
@property(nonatomic,assign)IBOutlet UILabel *labelActivity3;
@property(nonatomic,assign)IBOutlet UILabel *labelOneTicketIntegral;
@property(nonatomic,assign)IBOutlet UILabel *labelTicketNum;
@property(nonatomic,assign)IBOutlet UILabel *labelRankNum;
@property(nonatomic,assign)IBOutlet UILabel *labelSignInNum;
@property(nonatomic,assign)IBOutlet UILabel *labelPhoneFee;
@property(nonatomic,assign)IBOutlet UILabel *labelAbleFee;
-(void)updateView;
@end
