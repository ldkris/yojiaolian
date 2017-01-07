//
//  TeachLogUndoCell.m
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TeachLogUndoCell.h"
#import "TeachLogVC.h"
#import "WriteLogVC.h"
@implementation TeachLogUndoCell

- (void)awakeFromNib {
    // Initialization code
    [self.btnAgree setColor:YCC_Green];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.lineView0 setBackgroundColor:YCC_BorderColor];
    [self.lineView1 setBackgroundColor:YCC_BorderColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelName.text=[self.data objectForKey:@"studentname"];
    self.labelPhone.text=[self.data objectForKey:@"mobile"];
    self.labelOrderTime.text=[self.data objectForKey:@"date"];

    self.labelOperate.text=@"练车完成";
    [self.labelOperate setTextColor:YCC_Green];
}
-(IBAction)callPhone:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.labelPhone.text]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.delegate.view addSubview:callWebview];
}
-(IBAction)writeLog:(id)sender
{
    WriteLogVC *vc=[[WriteLogVC alloc] init];
    vc.preData=self.data;
    vc.delegate=self.delegate;
    [self.delegate.navigationController pushViewController:vc animated:YES];
}



@end
