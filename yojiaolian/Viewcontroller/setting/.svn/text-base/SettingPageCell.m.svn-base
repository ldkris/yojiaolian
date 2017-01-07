//
//  SettingPageCell.m
//  yojiaolian
//
//  Created by carcool on 4/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "SettingPageCell.h"
#import "SettingVC.h"
@implementation SettingPageCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    self.labelName.text=[self.data objectForKey:@"name"];
    self.labelPhone.text=[self.data objectForKey:@"telephone"];
    self.labelSchool.text=[self.data objectForKey:@"dsname"];
}
-(IBAction)editPhotoBtnPressed:(id)sender
{
    [self.delegate showEditPhotoVC];
}
-(IBAction)integralBtnPressed:(id)sender
{
    [self.delegate showIntegralDetailVC];
}
-(IBAction)aboutUsBtnPressed:(id)sender
{
    [self.delegate showAboutUsVC];
}
-(IBAction)logoutBtnPressed:(id)sender
{
    [self.delegate logoutBtnPressed];
}
-(IBAction)showEditInfoVC:(id)sender
{
    [self.delegate showEditInfoVC];
}
@end
