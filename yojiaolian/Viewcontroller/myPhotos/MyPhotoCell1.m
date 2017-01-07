//
//  MyPhotoCell1.m
//  yojiaolian
//
//  Created by carcool on 12/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyPhotoCell1.h"
#import "MyPhotosVC.h"
@implementation MyPhotoCell1

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.layer setBorderWidth:1.0];
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
    NSArray *aryPhotos=[self.delegate.userInfo objectForKey:@"imgurls"];
    NSInteger i=0;
    for (NSString *photoUrl in aryPhotos)
    {
        WebImageViewNormal *avatar=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(widthSep+(i%2)*(widthSep+120), 50+i/2*(80+20), 120, 80)];
        [avatar setWebImageViewWithURL:[NSURL URLWithString:photoUrl]];
        [avatar.layer setCornerRadius:4.0];
        [avatar setClipsToBounds:YES];
        [self addSubview:avatar];
        [self.m_aryAvatar addObject:avatar];
        i++;
    }
    
    [self.btnAdd setFrame:CGRectMake(widthSep+(i%2)*(widthSep+120), 50+i/2*(80+20), 120, 80)];
    [self addSubview:self.btnAdd];
}
-(IBAction)addBtnPressed:(id)sender
{
    [self.delegate updatePhoto];
}
@end
