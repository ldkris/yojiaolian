//
//  MyTicketVC.h
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface MyTicketVC : YCCViewController
@property(nonatomic,assign)IBOutlet UIButton *btnAvailable;
@property(nonatomic,assign)IBOutlet UIButton *btnGetAward;
@property(nonatomic,assign)IBOutlet UIButton *btnNoAward;
@property(nonatomic,assign)NSInteger type;//0:有效 1:已中奖 2:未中奖
@property(nonatomic,retain)IBOutlet UIView *lineViewType;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@end
