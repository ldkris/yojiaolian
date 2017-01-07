//
//  OrderTrainUndo.m
//  yojiaolian
//
//  Created by carcool on 10/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderTrainUndo.h"
#import "OrderTrainVC.h"
#import "RefuseOrderVC.h"
@implementation OrderTrainUndo

- (void)awakeFromNib {
    // Initialization code
    [self.btnAgree setColor:YCC_Green];
    [self.btnUnAgree setColor:YCC_TextColor];
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
    self.labelApplyTime.text=[self.data objectForKey:@"applytime"];
    self.labelName.text=[self.data objectForKey:@"studentname"];
    self.labelPhone.text=[self.data objectForKey:@"mobile"];
    self.labelOrderTime.text=[self.data objectForKey:@"appointtime"];
    switch ([[self.data objectForKey:@"status"] integerValue])
    {
        case 0:
            self.labelOperate.text=@"预约练车";
            [self.labelOperate setTextColor:YCC_Green];
            break;
        case 3:
            self.labelOperate.text=@"取消预约";
            [self.labelOperate setTextColor:[UIColor redColor]];
            break;
        default:
            break;
    }
    if ([[self.data objectForKey:@"status"] integerValue]==0)
    {
        [self.btnAgree setTitle:@"同意预约" forState:UIControlStateNormal];
        [self.btnUnAgree setTitle:@"拒绝预约" forState:UIControlStateNormal];
    }
    else
    {
        [self.btnAgree setTitle:@"同意取消" forState:UIControlStateNormal];
        [self.btnUnAgree setTitle:@"拒绝取消" forState:UIControlStateNormal];
    }
}
-(IBAction)callPhone:(id)sender
{
    UIWebView*callWebview =[[UIWebView alloc] init];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",self.labelPhone.text]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.delegate.view addSubview:callWebview];
}
-(IBAction)agreeOrder:(id)sender
{
    [self.delegate agreeOrder:[self.data objectForKey:@"appointid"] type:[[self.data objectForKey:@"status"] integerValue]==0?@"1":@"4"];
}
-(IBAction)refuseOrder:(id)sender
{
    RefuseOrderVC *vc=[[RefuseOrderVC alloc] init];
    vc.delegate=self.delegate;
    vc.preData=self.data;
    if ([[self.data objectForKey:@"status"] integerValue]==0)
    {
        vc.refuseType=@"1";
        vc.title=@"拒绝预约";
    }
    else if ([[self.data objectForKey:@"status"] integerValue]==3)
    {
        vc.refuseType=@"2";
        vc.title=@"拒绝取消";
    }
    [self.delegate.navigationController pushViewController:vc animated:YES];
}
@end
