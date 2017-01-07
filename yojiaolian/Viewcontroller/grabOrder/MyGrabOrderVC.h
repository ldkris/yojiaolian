//
//  MyGrabOrderVC.h
//  yojiaolian
//
//  Created by carcool on 3/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"

@interface MyGrabOrderVC : YCCViewController<UIAlertViewDelegate>
@property(nonatomic,retain)IBOutlet UIView *topbg;
@property(nonatomic,retain)UIView *topLineView;
@property(nonatomic,retain)IBOutlet UILabel *labelNew;
@property(nonatomic,retain)IBOutlet UILabel *labelGrabbed;
@property(nonatomic,assign)NSInteger type;//0:新订单 1:已抢订单
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSString *licenseType;
@property(nonatomic,retain)NSString *startTime;
@property(nonatomic,retain)NSString *endTime;
@property(nonatomic,retain)NSString *rulesUrl;
@property(nonatomic,retain)NSMutableArray *m_aryGrabedList;
@property(nonatomic,assign)IBOutlet UILabel *labelGrab1;
@property(nonatomic,assign)IBOutlet UILabel *labelGrab2;
@property(nonatomic,assign)NSInteger grabedIndex;
@property(nonatomic,assign)BOOL isPoped;
@property(nonatomic,assign)NSInteger applyStatus;//0待审核 1通过 2拒绝 -1未提交申请 -2违规 -3权限取消
@property(nonatomic,retain)NSString *applyRuleUrl;
-(void)grabOrder:(NSDictionary*)orderData;
-(void)submitCallEventOrderId:(NSString*)orderid;
-(void)applyBtnPressed;
-(void)showApplyRulesWebview;
-(void)getApplyGrabStatus;
@end
