//
//  IntegralListCell.h
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralListCell : UITableViewCell
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelAction;
@property(nonatomic,assign)IBOutlet UILabel *labelIntegral;
-(void)updateView;
@end
