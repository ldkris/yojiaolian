//
//  OrderTrainVC.h
//  yojiaolian
//
//  Created by carcool on 10/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "FiltrateOrderVC.h"
@interface OrderTrainVC : YCCViewController<FiltrateOrderVCDelegate>
@property(nonatomic,retain)IBOutlet UIView *doneSectionView;
@property(nonatomic,retain)IBOutlet UIView *doneSectionLineView0;
@property(nonatomic,assign)IBOutlet UIView *topbg;
@property(nonatomic,retain)UIView *topLineView;
@property(nonatomic,assign)IBOutlet UILabel *labelUndo;
@property(nonatomic,assign)IBOutlet UILabel *labelDone;
@property(nonatomic,retain)UIScrollView *m_scrollView;
@property(nonatomic,assign)NSInteger operateType;
@property(nonatomic,retain)UITableView *m_tableviewSocial;
@property(nonatomic,assign)NSInteger pageIndexSocial;
@property(nonatomic,assign)NSInteger pageCountSocial;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryDataSocial;
@property(nonatomic,retain)NSMutableDictionary *filtrateData;
-(void)agreeOrder:(NSString*)orderid type:(NSString*)type;
-(void)reloadAllData;
@end
