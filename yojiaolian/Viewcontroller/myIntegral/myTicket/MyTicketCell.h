//
//  MyTicketCell.h
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTicketCell : UITableViewCell
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)IBOutlet UILabel *labelCode;
@property(nonatomic,assign)IBOutlet UILabel *labelTimeExchang;
@property(nonatomic,assign)IBOutlet UILabel *labelTimeOffline;
@property(nonatomic,assign)IBOutlet UIImageView *imgType;
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)NSInteger type;
-(void)updateView;
@end
