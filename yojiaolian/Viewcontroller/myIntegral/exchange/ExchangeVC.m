//
//  ExchangeVC.m
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ExchangeVC.h"
#import "ExchangeSuccessVC.h"
@interface ExchangeVC ()

@end

@implementation ExchangeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"兑换抽奖券";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];

    self.textFieldNumber.delegate=self;
    self.textFieldNumber.returnKeyType=UIReturnKeyDone;
    self.labelIntegral.hidden=YES;
    self.labelNotice.hidden=YES;
    self.labelTicket.hidden=YES;
    [self.btnExchange setColor:[UIColor lightGrayColor]];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"兑换奖券"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"兑换奖券"];
    [self updateData];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"activity/getIntegralInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
            [self updateView];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];

}
-(void)updateView
{
    self.textFieldNumber.text=@"";
    
    self.labelIntegral.text=[NSString stringWithFormat:@"每%d积分可兑换一张，已兑换的抽奖券当月有效。",[[self.data objectForKey:@"unitNum"] integerValue]];
    self.labelTicket.text=[NSString stringWithFormat:@"您目前的可使用积分可兑换%d张抽奖券",[[self.data objectForKey:@"raffleNum"] integerValue]];
    self.labelNotice.text=[self.data objectForKey:@"exchange_msg"];
    if ([[self.data objectForKey:@"exchange_status"] integerValue]==1)
    {
        self.labelIntegral.hidden=NO;
        self.labelTicket.hidden=NO;
        self.labelNotice.hidden=YES;
        [self.btnExchange setColor:YCC_Green];
    }
    else
    {
        self.labelIntegral.hidden=YES;
        self.labelTicket.hidden=YES;
        self.labelNotice.hidden=NO;
        [self.btnExchange setColor:[UIColor lightGrayColor]];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------- textfield delegate -----------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------- event response -------------
-(IBAction)exchangeBtnPressed:(id)sender
{
    if ([self.btnExchange.backgroundColor isEqual:[UIColor lightGrayColor]])
    {
        return;
    }
    if([self.textFieldNumber.text isEqualToString:@""]||[self.textFieldNumber.text integerValue]<=0)
    {
        [self showMessage:@"请输入兑换奖券数量"];
        return;
    }
    else if (![MyFounctions isPureNumandCharacters:self.textFieldNumber.text])
    {
        [self showMessage:@"请输入数字"];
        return;
    }
    
    Http *req=[[Http alloc] init];
    req.socialMethord=@"activity/useMyIntegral.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textFieldNumber.text] forKeys:@[@"mobile",@"sheetNum"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            ExchangeSuccessVC *vc=[[ExchangeSuccessVC alloc] init];
            vc.data=req.m_data;
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            if ([req.m_data valueForKey:@"msg"])
            {
                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
            }
            else
            {
                [self showNetworkError];
            }
            
        }
        
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
