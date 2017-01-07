//
//  RefuseOrderCell.h
//  yojiaolian
//
//  Created by carcool on 10/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RefuseOrderCell : UITableViewCell<UITextViewDelegate>
@property(nonatomic,retain)IBOutlet UITextView *textViewContent;
@property(nonatomic,retain)IBOutlet UIButton *btnWriteConetnt;
@property(nonatomic,retain)IBOutlet UILabel *labelContentDefault;
@property(nonatomic,retain)NSMutableArray *m_aryData;
@property(nonatomic,retain)NSMutableArray *m_aryShowed;
@property(nonatomic,retain)NSMutableArray *m_aryImgs;
-(void)updateView;
@end
