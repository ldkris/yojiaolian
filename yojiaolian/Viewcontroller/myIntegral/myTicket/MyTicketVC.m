//
//  MyTicketVC.m
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyTicketVC.h"
#import "MyTicketCell.h"
@interface MyTicketVC ()

@end

@implementation MyTicketVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"我的抽奖券";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.type=0;
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64+40, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupFooter];
    [self setupHeader];
    
    [self.btnAvailable setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [self.btnGetAward setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.btnNoAward setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [self.lineViewType setFrame:CGRectMake(0, PARENT_Y(self.lineViewType), PARENT_WIDTH(self.lineViewType), PARENT_HEIGHT(self.lineViewType))];
    
    [self updateData];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"我的抽奖券"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"我的抽奖券"];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"activity/getRaffleTicketList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount],[NSString stringWithFormat:@"%d",self.type]] forKeys:@[@"mobile",@"pageindex",@"pagesize",@"type"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndex==1)
            {
                [self.m_aryData removeAllObjects];
            }
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"tickets"]];
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
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyTicketCell *cell=[tableView dequeueReusableCellWithIdentifier:@"MyTicketCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"MyTicketCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.data=[self.m_aryData objectAtIndex:indexPath.row];
    cell.type=self.type;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
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
#pragma  mark ------ refresh delegate
-(void)headerRefresh
{
    self.pageIndex=1;
    [self updateData];
}
-(void)footerRefresh
{
    self.pageIndex++;
    [self updateData];
}
-(IBAction)typeBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    self.type=btn.tag;
    if (self.type==0)
    {
        [self.btnAvailable setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.btnGetAward setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnNoAward setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.lineViewType setFrame:CGRectMake(0, PARENT_Y(self.lineViewType), PARENT_WIDTH(self.lineViewType), PARENT_HEIGHT(self.lineViewType))];
        } completion:^(BOOL finished) {
            self.pageIndex=1;
            [self updateData];
        }];
        
    }
    else if (self.type==2)
    {
        [self.btnAvailable setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnGetAward setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [self.btnNoAward setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.lineViewType setFrame:CGRectMake(107, PARENT_Y(self.lineViewType), PARENT_WIDTH(self.lineViewType), PARENT_HEIGHT(self.lineViewType))];
        } completion:^(BOOL finished) {
            self.pageIndex=1;
            [self updateData];
        }];
    }
    else if (self.type==1)
    {
        [self.btnAvailable setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnGetAward setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [self.btnNoAward setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.lineViewType setFrame:CGRectMake(213, PARENT_Y(self.lineViewType), PARENT_WIDTH(self.lineViewType), PARENT_HEIGHT(self.lineViewType))];
        } completion:^(BOOL finished) {
            self.pageIndex=1;
            [self updateData];
        }];
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
