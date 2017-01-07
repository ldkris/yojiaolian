//
//  MyPhotoCell0.h
//  yojiaolian
//
//  Created by carcool on 12/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyPhotosVC;
@interface MyPhotoCell0 : UITableViewCell
@property(nonatomic,assign)MyPhotosVC *delegate;
@property(nonatomic,retain)IBOutlet UIButton *btnAdd;
@property(nonatomic,assign)IBOutlet UIView *contentBG;
@property(nonatomic,assign)IBOutlet UILabel *labelTitle;
@property(nonatomic,retain)NSMutableArray *m_aryAvatar;
-(void)updateView;
@end
