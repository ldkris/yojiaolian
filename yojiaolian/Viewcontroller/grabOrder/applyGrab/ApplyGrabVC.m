//
//  ApplyGrabVC.m
//  yojiaolian
//
//  Created by carcool on 4/27/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ApplyGrabVC.h"
#import "WebViewVC.h"
#import "MyGrabOrderVC.h"
@interface ApplyGrabVC ()

@end

@implementation ApplyGrabVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"申请开通抢单";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    [self updateData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grap/getApplyInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
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
#pragma mark --------- event response -------------
-(IBAction)showOrderRules:(id)sender
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=[self.data objectForKey:@"appointUrl"];
    vc.title=@"使用预约";
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showGetGoodNum:(id)sender
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=[self.data objectForKey:@"likeUrl"];
    vc.title=@"获得点赞";
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showCoachStander:(id)sender
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=[self.data objectForKey:@"serviceUrl"];
    vc.title=@"服务标准";
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showThirtyPart:(id)sender
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=[self.data objectForKey:@"protocolUrl"];
    vc.title=@"学车保障三方协议";
    [self.navigationController pushViewController:vc animated:YES];
}
-(IBAction)showMustAgree:(id)sender
{
    [self showMessage:@"需同意“优车车教练服务标准”"];
}
-(IBAction)showAgreeThirtyPart:(id)sender
{
    [self showMessage:@"需同意“优车车优车车学车保障三方协议”"];
}
-(IBAction)submitApply:(id)sender
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grap/putCoachApplyGrab.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"您的申请已提交，审核通过后，您就能开始抢单啦" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag=11;
            [alert show];
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
#pragma mark ---------- alertview delegate ----------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        [self popSelfViewContriller];
        [self.delegate getApplyGrabStatus];
    }
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
