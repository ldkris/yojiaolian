//
//  IntegralRankVC.m
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "IntegralRankVC.h"
#import "IntegralRankCell.h"
@interface IntegralRankVC ()

@end

@implementation IntegralRankVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"积分排名前20";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryData=[NSMutableArray array];
    self.pageCount=15;
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 70+40, Screen_Width, Screen_Height-70-40-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    
    [self.bottomView setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.bottomView];
    
    [self updateData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"积分排名前20"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"积分排名前20"];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"activity/getRankingList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"ranks"]];
            [self.m_tableView reloadData];
            
            self.labelMyRank.text=[req.m_data objectForKey:@"ranking"];
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
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IntegralRankCell *cell=[tableView dequeueReusableCellWithIdentifier:@"IntegralRankCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"IntegralRankCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
