//
//  NewOrderCell.m
//  yojiaolian
//
//  Created by carcool on 3/14/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "NewOrderCell.h"
#import "MyGrabOrderVC.h"
@implementation NewOrderCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:3.0];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.btnGrab setColor:YCC_Green];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    self.labelName.text=[self.data objectForKey:@"username"];
    self.labelOrderTime.text=[self.data objectForKey:@"createtime"];
    self.labelLicense.text=[self.data objectForKey:@"drivetype"];
    self.labelArea.text=[self.data objectForKey:@"address"];
    self.labelMark.text=[self.data objectForKey:@"remarks"];
    self.labelLeftTime.text=[self.data objectForKey:@"endtime"];
}
-(IBAction)phoneBtnPressed:(id)sender
{
    [self.delegate showMessage:@"抢单之后才能拨打电话"];
}
-(IBAction)grabBtnPressed:(id)sender
{
    [self.delegate grabOrder:self.data];
}
@end
