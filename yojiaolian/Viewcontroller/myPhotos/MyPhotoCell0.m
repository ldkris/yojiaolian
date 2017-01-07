//
//  MyPhotoCell0.m
//  yojiaolian
//
//  Created by carcool on 12/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyPhotoCell0.h"
#import "MyPhotosVC.h"
@implementation MyPhotoCell0

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self setBackgroundColor:YCC_GrayBG];
    [self.contentBG.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.contentBG.layer setBorderWidth:1.0];
    self.m_aryAvatar=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    for (WebImageViewNormal *subView in self.m_aryAvatar)
    {
        [subView removeFromSuperview];
    }
    [self.btnAdd removeFromSuperview];
    [self.m_aryAvatar removeAllObjects];
    
    float widthSep=80/3.0;
    if ([[self.delegate.userInfo objectForKey:@"headimgurl"] isEqualToString:@""])
    {
        [self.btnAdd setFrame:CGRectMake(widthSep, 60, 120, 120)];
        [self addSubview:self.btnAdd];
    }
    else
    {
        WebImageViewNormal *avatar=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(widthSep, 60, 120, 120)];
        [avatar setWebImageViewWithURL:[NSURL URLWithString:[self.delegate.userInfo objectForKey:@"headimgurl"]]];
        [avatar.layer setCornerRadius:4.0];
        [avatar setClipsToBounds:YES];
        [self addSubview:avatar];
        [self.m_aryAvatar addObject:avatar];
        
        [self.btnAdd setFrame:CGRectMake(widthSep*2+120, 60, 120, 120)];
        [self addSubview:self.btnAdd];
    }
    
}
-(IBAction)updateAvatarBtnPressed:(id)sender
{
    [self.delegate updateAvart];
}
@end
