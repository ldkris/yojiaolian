//
//  CityListVC.h
//  yojiaolian
//
//  Created by carcool on 4/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
@class EditInfoVC;
@interface CityListVC : YCCViewController
@property(nonatomic,assign)IBOutlet UILabel *labelCurrentCity;
@property(nonatomic,retain)UITableView *m_tableView2;
@property(nonatomic,assign)NSInteger provinceIndex;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryCitys;
@property(nonatomic,assign)EditInfoVC *delegate;
@end
