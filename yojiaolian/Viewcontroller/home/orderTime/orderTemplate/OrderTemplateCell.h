//
//  OrderTemplateCell.h
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTemplatesVC;
@interface OrderTemplateCell : UITableViewCell
@property(nonatomic,assign)OrderTemplatesVC *delegate;
@property(nonatomic,retain)IBOutlet UIButton *btn;
@property(nonatomic,assign)IBOutlet UILabel *labelTitle;
@property(nonatomic,assign)IBOutlet UILabel *labelContent;
@property(nonatomic,retain)NSDictionary *data;
-(void)updateView;
@end
