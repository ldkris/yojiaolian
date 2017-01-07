//
//  OrderTimeCellSet.h
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OrderTimeVC;
@interface OrderTimeCellSet : UITableViewCell
@property(nonatomic,assign)IBOutlet UILabel *labelRepeat;
@property(nonatomic,assign)IBOutlet UILabel *labelDay;
@property(nonatomic,assign)OrderTimeVC *delegate;
@end
