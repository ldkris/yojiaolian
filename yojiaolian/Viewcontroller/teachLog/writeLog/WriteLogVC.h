//
//  WriteLogVC.h
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "WriteLogCell.h"
#import "TeachLogVC.h"
@interface WriteLogVC : YCCViewController
@property(nonatomic,retain)NSDictionary *preData;
@property(nonatomic,assign)IBOutlet UIButton *btn;
@property(nonatomic,assign)TeachLogVC *delegate;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)WriteLogCell *m_cell;
@end
