//
//  MyIntegralCell.m
//  yojiaolian
//
//  Created by carcool on 12/9/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyIntegralCell.h"

@implementation MyIntegralCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.btnExchange setColor:YCC_PinkColor];
    [self.btnMyTicket setColor:YCC_Green];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelAble.text=[self.data objectForKey:@"integral"];
    self.labelAbleFee.text=[NSString stringWithFormat:@"(累计%@元可兑换)",[self.data objectForKey:@"fee"]];
    self.labelActivity1.text=[[[self.data objectForKey:@"activitys"] objectAtIndex:0] objectForKey:@"name"];
    self.labelActivity2.text=[[[self.data objectForKey:@"activitys"] objectAtIndex:1] objectForKey:@"name"];
    self.labelActivity3.text=[[[self.data objectForKey:@"activitys"] objectAtIndex:2] objectForKey:@"name"];
    self.labelDisale.text=[self.data objectForKey:@"usedIntegral"];
    self.labelOneTicketIntegral.text=[NSString stringWithFormat:@"%@积分＝1张抽奖券",[self.data objectForKey:@"unitNum"]];
    self.labelPhoneFee.text=[NSString stringWithFormat:@"%@元",[self.data objectForKey:@"phoneFee"]];
    self.labelRankNum.text=[self.data objectForKey:@"ranking"];
    self.labelSignInNum.text=[self.data objectForKey:@"signNum"];
    self.labelTicketNum.text=[self.data objectForKey:@"sheetNum"];
    self.labelTotal.text=[self.data objectForKey:@"totalIntegral"];
}

-(IBAction)showExchangeVC:(id)sender
{
    [self.delegate showExchangeVC];
}
-(IBAction)showMyTicketVC:(id)sender
{
    [self.delegate showMyTicketVC];
}
-(IBAction)showMyIntegralDetailVC:(id)sender
{
    [self.delegate showMyIntegralDetailVC];
}
-(IBAction)showMyIntegralRank:(id)sender
{
    [self.delegate showIntegralRankVC];
}
-(IBAction)showIntegralRule:(id)sender
{
    [self.delegate showWebViewVC:[self.data objectForKey:@"ruleurl"] title:@"积分规则"];
}
-(IBAction)showActivityRule:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self.delegate showWebViewVC:[[[self.data objectForKey:@"activitys"] objectAtIndex:btn.tag] objectForKey:@"activity_ruleurl"] title:[[[self.data objectForKey:@"activitys"] objectAtIndex:btn.tag] objectForKey:@"name"]];
}
@end
