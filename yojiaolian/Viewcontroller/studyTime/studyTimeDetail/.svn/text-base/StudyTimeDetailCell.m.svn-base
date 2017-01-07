//
//  StudyTimeDetailCell.m
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "StudyTimeDetailCell.h"

@implementation StudyTimeDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    [self.lineView3 setBackgroundColor:YCC_GrayBG];
    [self.lineView4 setBackgroundColor:YCC_GrayBG];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:4.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    if ([[self.data objectForKey:@"teachingitem"] integerValue]==2)
    {
        self.labelClass.text=@"科目二";
    }
    else
    {
        self.labelClass.text=@"科目三";
    }
    self.labelName.text=[self.data objectForKey:@"studentname"];
    self.labelPhone.text=[self.data objectForKey:@"mobile"];
    self.labelApplyTime.text=[self.data objectForKey:@"applytime"];
    self.labelDate.text=[self.data objectForKey:@"appointtime"];
    self.labelTime.text=[self.data objectForKey:@"periodtime"];
    self.labelUseTime.text=[self.data objectForKey:@"periodnum"];
}

@end
