//
//  GrabedOrderCell.m
//  yojiaolian
//
//  Created by carcool on 3/14/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "GrabedOrderCell.h"
#import "MyGrabOrderVC.h"
@implementation GrabedOrderCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=YCC_GrayBG;
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.contentBG setClipsToBounds:YES];
    [self.contentBG.layer setCornerRadius:3.0];
    [self.avatar setClipsToBounds:YES];
    [self.avatar.layer setCornerRadius:PARENT_WIDTH(self.avatar)/2.0];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    self.labelName.text=[self.data objectForKey:@"username"];
    self.labelOrderTime.text=[self.data objectForKey:@"createtime"];
    self.labelLicense.text=[self.data objectForKey:@"drivetype"];
    self.labelArea.text=[self.data objectForKey:@"address"];
    self.labelMark.text=[self.data objectForKey:@"remarks"];
}
-(IBAction)phoneBtnPressed:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",[self.data objectForKey:@"mobile"]]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.delegate.view addSubview:callWebview];
    
    [self.delegate submitCallEventOrderId:[[self.data objectForKey:@"did"] stringValue]];
}
@end
