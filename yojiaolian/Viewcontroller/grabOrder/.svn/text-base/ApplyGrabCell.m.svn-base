//
//  ApplyGrabCell.m
//  yojiaolian
//
//  Created by carcool on 4/26/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ApplyGrabCell.h"
#import "MyGrabOrderVC.h"
@implementation ApplyGrabCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.btn setColor:YCC_Green];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.btn.hidden=NO;
    if (self.applyType==1)
    {
        self.labelNote.text=@"由于您多次违反了教练服务标准，已被管理员取消抢单权限，如有疑问，请致电400-6909-879";
        self.btn.hidden=YES;
    }
    else if (self.applyType==-3)
    {
        self.labelNote.text=@"您的抢单权限已被取消，如有疑问请致电400-6909-879";
    }
    else
    {
        self.labelNote.text=@"您还没有开通抢单功能";
    }
}
-(IBAction)appleBtnPressed:(id)sender
{
    [self.delegate applyBtnPressed];
}
-(IBAction)appleRulesBtnPressed:(id)sender
{
    [self.delegate showApplyRulesWebview];
}
@end
