//
//  HomeFuncCell.m
//  yojiaolian
//
//  Created by carcool on 10/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeFuncCell.h"
#import "HomeVC.h"
@implementation HomeFuncCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.labelCount1 setClipsToBounds:YES];
    [self.labelCount1.layer setCornerRadius:PARENT_WIDTH(self.labelCount1)/2.0];
    self.labelCount1.hidden=YES;
    [self.labelCount2 setClipsToBounds:YES];
    [self.labelCount2.layer setCornerRadius:PARENT_WIDTH(self.labelCount2)/2.0];
    self.labelCount2.hidden=YES;
    [self.labelCount3 setClipsToBounds:YES];
    [self.labelCount3.layer setCornerRadius:PARENT_WIDTH(self.labelCount3)/2.0];
    self.labelCount3.hidden=YES;
    [self.labelCount4 setClipsToBounds:YES];
    [self.labelCount4.layer setCornerRadius:PARENT_WIDTH(self.labelCount4)/2.0];
    self.labelCount4.hidden=YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    for (NSDictionary *dic in self.m_aryData)
    {
        if ([[dic objectForKey:@"code"] integerValue]==3)//order train
        {
            self.labelCount1.text=[[dic objectForKey:@"count"] stringValue];
            if ([self.labelCount1.text isEqualToString:@"0"])
            {
                self.labelCount1.hidden=YES;
            }
            else
            {
                self.labelCount1.hidden=NO;
            }
        }
        else if ([[dic objectForKey:@"code"] integerValue]==1)//teach log
        {
            self.labelCount2.text=[[dic objectForKey:@"count"] stringValue];
            if ([[[dic objectForKey:@"count"] stringValue] isEqualToString:@"0"])
            {
                self.labelCount2.hidden=YES;
            }
            else
            {
                self.labelCount2.hidden=NO;
            }
        }
    }
    
    NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
    if ([userdefaults objectForKey:@"grab"])
    {
        self.labelCount3.text=[userdefaults objectForKey:@"grab"];
        if ([self.labelCount3.text integerValue]>0)
        {
            self.labelCount3.hidden=NO;
        }
        else
        {
            self.labelCount3.hidden=YES;
        }
    }
}
-(IBAction)btnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        [self.delegate showOrderTrainVC];
    }
    else if (btn.tag==1)
    {
        [self.delegate showTrainRecordsListVC];
    }
    else if (btn.tag==2)
    {
        [self.delegate showOrderTimeVC];
    }
    else if (btn.tag==3)
    {
        [self.delegate showStudyTimeVC];
    }
    else if (btn.tag==4)
    {
        [self.delegate showCoachDetail];
    }
    else if (btn.tag==5)
    {
        [self.delegate showIntegralVC];
    }
    else if (btn.tag==6)
    {
        [self.delegate showMyGrabOrederVC];
    }
    else if (btn.tag==7)
    {
        [self.delegate showMyOrdersVC];
    }
    else if (btn.tag==8)
    {
        [self.delegate showVoiceIntraduction];
    }
}
@end
