//
//  StudyTimeVC.h
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import "FiltrateOrderVC.h"
@interface StudyTimeVC : YCCViewController<FiltrateOrderVCDelegate>
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryDataTotal;
@property(nonatomic,retain)NSMutableDictionary *filtrateData;
@end
