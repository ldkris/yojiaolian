//
//  CoachDetailCellInfo.m
//  yojiaolian
//
//  Created by carcool on 4/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CoachDetailCellInfo.h"
#import "CoachDetailVC.h"
@implementation CoachDetailCellInfo

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    [self.labelboy setTextColor:YCC_TextColor];
    [self.labelgirl setTextColor:YCC_TextColor];
    [self.labelpeople setTextColor:YCC_TextColor];
    [self.labelSchool setTextColor:YCC_TextColor];
    [self.labelstar setTextColor:YCC_TextColor];
    [self.labelTeachAge setTextColor:YCC_TextColor];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateViews
{
    self.labelName.text=[self.delegate.coachData objectForKey:@"name"];
    
    float labelNameWidth=[MyFounctions calculateTextWidth:[self.delegate.coachData objectForKey:@"name"] font:[UIFont systemFontOfSize:16]];
    [self.imgZhiying removeFromSuperview];
    self.imgZhiying=nil;
    [self.imgFens removeFromSuperview];
    self.imgFens=nil;
    NSInteger imgNum=0;
//    if([[self.delegate.coachData objectForKey:@"self_run"] integerValue]==2)
//    {
//        self.imgZhiying=[[UIImageView alloc] initWithFrame:CGRectMake(PARENT_X(self.labelName)+labelNameWidth+10+imgNum*(31+10), 10, 31, 16)];
//        [self.imgZhiying setImage:[UIImage imageNamed:@"zhiying"]];
//        [self addSubview:self.imgZhiying];
//        imgNum++;
//    }
    if ([[self.delegate.coachData objectForKey:@"timing"] integerValue]==2)
    {
        self.imgFens=[[UIImageView alloc] initWithFrame:CGRectMake(PARENT_X(self.labelName)+labelNameWidth+10+imgNum*(31+10), 10, 31, 16)];
        [self.imgFens setImage:[UIImage imageNamed:@"fens"]];
        [self addSubview:self.imgFens];
        imgNum++;
    }
    
    self.labelSchool.text=[NSString stringWithFormat:@"%@,%@",[self.delegate.coachData objectForKey:@"dsname"],[self.delegate.coachData objectForKey:@"teachItem"]];
    self.labelTeachAge.text=[NSString stringWithFormat:@"%d年教龄",[[self.delegate.coachData objectForKey:@"jl"] integerValue]];
    self.labelpeople.text=[NSString stringWithFormat:@"%d",[[self.delegate.coachData objectForKey:@"studentcount"] integerValue]];
    self.labelgirl.text=[[self.delegate.coachData objectForKey:@"femalecount"] stringValue];
    self.labelboy.text=[[self.delegate.coachData objectForKey:@"malecount"] stringValue];
    self.labelstar.text=[NSString stringWithFormat:@"%d",[[self.delegate.coachData objectForKey:@"goodNum"] integerValue]];
}
@end
