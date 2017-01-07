//
//  TeachLogDetailCell.m
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TeachLogDetailCell.h"

@implementation TeachLogDetailCell

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
    [self.labelReason removeFromSuperview];
    self.labelReason=nil;
    NSString *reason=[self.data objectForKey:@"log_desc"];
    float contentHeight=[MyFounctions calculateLabelHeightWithString:reason Width:224 font:[UIFont systemFontOfSize:14]];
    self.labelReason=[[UILabel alloc] initWithFrame:CGRectMake(88, 319, 224, contentHeight)];
    self.labelReason.numberOfLines=0;
    [self.labelReason setTextColor:[UIColor darkGrayColor]];
    [self.labelReason setFont:[UIFont systemFontOfSize:14.0]];
    self.labelReason.text=reason;
    [self addSubview:self.labelReason];
    
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
    switch ([[self.data objectForKey:@"status"] integerValue])
    {
        case 6:
            self.labelStatus.text=@"已写日志";
            [self.labelStatus setTextColor:YCC_Green];
            self.labelRefuse.hidden=NO;
            break;
        case 7:
            self.labelStatus.text=@"学员未到";
            [self.labelStatus setTextColor:[UIColor redColor]];
            self.labelRefuse.hidden=YES;
            break;
            
        default:
            break;
    }
    
    self.labelDate.text=[self.data objectForKey:@"appointtime"];
    self.labelTime.text=[self.data objectForKey:@"periodtime"];
}
-(IBAction)callPhone:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.labelPhone.text]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.delegate.view addSubview:callWebview];
}

@end
