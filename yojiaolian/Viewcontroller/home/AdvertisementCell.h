//
//  AdvertisementCell.h
//  yojiaolian
//
//  Created by carcool on 12/12/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeVC.h"
@interface AdvertisementCell : UITableViewCell<ImagePlayerViewDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property (retain, nonatomic)IBOutlet ImagePlayerView *imagePlayerView;
@property(nonatomic,assign)HomeVC *delegate;
@property(nonatomic,assign)IBOutlet UILabel *labelZhaosheng;
@property(nonatomic,assign)IBOutlet UILabel *labelTongguolv;
@property(nonatomic,assign)IBOutlet UILabel *labeljiaolian;
@property(nonatomic,assign)IBOutlet UILabel *labelBaomingNum;
@property(nonatomic,assign)IBOutlet UILabel *labelQiangdanNum;
@property(nonatomic,assign)IBOutlet UILabel *labelYoubobao;
@property(nonatomic,assign)NSInteger scrollIndex;
-(void)updateView;
@end
