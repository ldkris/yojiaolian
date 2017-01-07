//
//  MyIntegralVC.m
//  yojiaolian
//
//  Created by carcool on 12/8/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyIntegralVC.h"
#import "MyIntegralCell.h"
#import "ExchangeVC.h"
#import "MyTicketVC.h"
#import "MyIntegralDetailVC.h"
#import "IntegralRankVC.h"
#import "WebViewVC.h"
@interface MyIntegralVC ()

@end

@implementation MyIntegralVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"我的积分";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"我的积分"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"我的积分"];
    [self updateData];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"activity/getMyIntegral.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=req.m_data;
            [self.m_tableView reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyIntegralCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyIntegralCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MyIntegralCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=self.data;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark --------- event response ------------
-(void)showExchangeVC
{
    ExchangeVC *vc=[[ExchangeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyTicketVC
{
    MyTicketVC *vc=[[MyTicketVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyIntegralDetailVC
{
    MyIntegralDetailVC *vc=[[MyIntegralDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showIntegralRankVC
{
    IntegralRankVC *vc=[[IntegralRankVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showWebViewVC:(NSString*)url title:(NSString*)title
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=url;
    vc.title=title;
    [self.navigationController pushViewController:vc animated:YES];
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
