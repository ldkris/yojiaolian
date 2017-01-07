//
//  GrabedOrderCell.h
//  yojiaolian
//
//  Created by carcool on 3/14/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyGrabOrderVC;
@interface GrabedOrderCell : UITableViewCell
@property(nonatomic,retain)NSDictionary *data;
@property(nonatomic,assign)MyGrabOrderVC *delegate;
@property(nonatomic,assign)IBOutlet UIView *contentBG;
@property(nonatomic,assign)IBOutlet WebImageViewNormal *avatar;
@property(nonatomic,assign)IBOutlet UILabel *labelName;
@property(nonatomic,assign)IBOutlet UILabel *labelOrderTime;
@property(nonatomic,assign)IBOutlet UILabel *labelLicense;
@property(nonatomic,assign)IBOutlet UILabel *labelArea;
@property(nonatomic,assign)IBOutlet UILabel *labelMark;
-(void)updateView;
@end
