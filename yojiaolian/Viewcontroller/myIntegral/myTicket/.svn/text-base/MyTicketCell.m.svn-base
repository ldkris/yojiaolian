//
//  MyTicketCell.m
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyTicketCell.h"

@implementation MyTicketCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelCode.text=[self.data objectForKey:@"code"];
    self.labelTimeExchang.text=[NSString stringWithFormat:@"本券兑换日期：%@",[self.data objectForKey:@"useDate"]];
    self.labelTimeOffline.text=[NSString stringWithFormat:@"有效截止日期：%@",[self.data objectForKey:@"validEndDate"]];
    if (self.type==0)
    {
        self.imgType.hidden=YES;
    }
    else
    {
        self.imgType.hidden=NO;
        if ([[self.data objectForKey:@"status"] integerValue]==2)
        {
            [self.imgType setImage:[UIImage imageNamed:@"getAward"]];
        }
        else if ([[self.data objectForKey:@"status"] integerValue]==1)
        {
            [self.imgType setImage:[UIImage imageNamed:@"noAward"]];
        }
        
    }
}
@end
