//
//  TeachLogDoneCell.h
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachLogDoneCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelDate;
@property(nonatomic,assign)IBOutlet UILabel *labelStatus;
-(void)updateView;
@end
