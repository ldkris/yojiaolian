//
//  IntegralRankCell.h
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntegralRankCell : UITableViewCell
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelIntegral;
@property(nonatomic,assign)IBOutlet UILabel *labelRank;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateView;
@end
