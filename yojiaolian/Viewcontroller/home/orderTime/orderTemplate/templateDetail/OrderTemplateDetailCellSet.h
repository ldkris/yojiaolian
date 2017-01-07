//
//  OrderTemplateDetailCellSet.h
//  yojiaolian
//
//  Created by carcool on 4/29/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTemplateDetailVC;
@interface OrderTemplateDetailCellSet : UITableViewCell
@property(nonatomic,assign)IBOutlet UILabel *labelRepeat;
@property(nonatomic,assign)IBOutlet UILabel *labelDay;
@property(nonatomic,assign)OrderTemplateDetailVC *delegate;
@end
