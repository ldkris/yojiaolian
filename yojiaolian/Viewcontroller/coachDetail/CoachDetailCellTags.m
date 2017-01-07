//
//  CoachDetailCellTags.m
//  yojiaolian
//
//  Created by carcool on 4/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CoachDetailCellTags.h"

@implementation CoachDetailCellTags

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.m_aryBtns=[NSMutableArray array];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.contentBG removeFromSuperview];
    self.contentBG=nil;
    self.contentBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 40*(self.m_aryData.count/4+(self.m_aryData.count%4>0?1:0)))];
    [self.contentBG setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.contentBG];
    
    for (UIButton *btn in self.m_aryBtns)
    {
        [btn removeFromSuperview];
    }
    [self.m_aryBtns removeAllObjects];
    
    float btnWidth=(320-50)/4.0;
    NSInteger i=0;
    for (NSString *tag in self.m_aryData)
    {
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.userInteractionEnabled=NO;
        [btn setFrame:CGRectMake(10+(i%4)*(10+btnWidth), 5+(i/4)*40, btnWidth, 30)];
        [btn setClipsToBounds:YES];
        [btn.layer setCornerRadius:3.0];
        [btn.titleLabel setFont:[UIFont systemFontOfSize:12.0]];
        [btn setTitle:tag forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [btn setBackgroundColor:[UIColor whiteColor]];
        [btn.titleLabel setTextColor:[UIColor lightGrayColor]];
        [btn.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
        [btn.layer setBorderWidth:0.5];
        
        [self.contentBG addSubview:btn];
        [self.m_aryBtns addObject:btn];
        i++;
    }
}
@end
