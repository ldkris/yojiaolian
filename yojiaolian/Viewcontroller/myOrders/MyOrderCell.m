//
//  MyOrderCell.m
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "MyOrderCell.h"
#import "MyOrdersVC.h"
@implementation MyOrderCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:3.0];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelLicenseType.text=[self.data objectForKey:@"drivetype"];
    self.labelName.text=[self.data objectForKey:@"studentname"];
    self.labelPrice.text=[self.data objectForKey:@"fee"];
    self.labelState.text=[self.data objectForKey:@"payStatus"];
    self.labelTime.text=[self.data objectForKey:@"payTime"];
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
}
-(IBAction)callBtnPressed:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[self.data objectForKey:@"mobile"]]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.delegate.view addSubview:callWebview];
}
@end
