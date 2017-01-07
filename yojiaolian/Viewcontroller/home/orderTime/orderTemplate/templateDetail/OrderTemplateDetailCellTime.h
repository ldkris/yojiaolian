//
//  OrderTemplateDetailCellTime.h
//  yojiaolian
//
//  Created by carcool on 4/29/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTemplateDetailVC;
@interface OrderTemplateDetailCellTime : UITableViewCell
@property(nonatomic,assign)IBOutlet UILabel *labelTime;
@property(nonatomic,assign)IBOutlet UILabel *labelPeople;
@property(nonatomic,assign)IBOutlet UIView *lineView0;
@property(nonatomic,assign)NSInteger timeIndex;
@property(nonatomic,assign)OrderTemplateDetailVC *delegate;
@end
