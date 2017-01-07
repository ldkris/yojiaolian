//
//  MyGrabOrderVC.m
//  yojiaolian
//
//  Created by carcool on 3/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "MyGrabOrderVC.h"
#import "NewOrderCell.h"
#import "GrabedOrderCell.h"
#import "WebViewVC.h"
#import "ApplyGrabCell.h"
#import "WebViewVC.h"
#import "EditInfoVC.h"
#import "ApplyGrabVC.h"
#import "ApplyCheckingCell.h"
@interface MyGrabOrderVC ()

@end

@implementation MyGrabOrderVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"我的抢单";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popVC) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"抢单规则"];
    [self.rightNaviBtn addTarget:self action:@selector(showGrabOrderRules) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryData=[NSMutableArray array];
    self.type=0;
    self.isPoped=NO;
    self.licenseType=@"";
    self.startTime=@"";
    self.endTime=@"";
    self.rulesUrl=@"";
    self.grabedIndex=0;
    self.applyRuleUrl=@"";
    self.applyStatus=-99;
    self.topbg.hidden=YES;
    self.m_aryGrabedList=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64+35+30, Screen_Width, Screen_Height-64-35-30)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    self.topLineView=[[UIView alloc] initWithFrame:CGRectMake(0,33, 160, 2)];
    [self.topLineView setBackgroundColor:YCC_Green];
    [self.topbg addSubview:self.topLineView];
    [self.labelNew setTextColor:YCC_Green];
    [self.labelGrabbed setTextColor:[UIColor darkGrayColor]];
    
    [self getRulesAndGrabList];
    [self getApplyGrabStatus];
    //set grab note num 0
    [self clearGrabNewMessage];
}
-(void)popVC
{
    self.isPoped=YES;
    [self popSelfViewContriller];
}
-(void)getApplyGrabStatus
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grap/checkWhetherApplied.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.applyStatus=[[req.m_data objectForKey:@"status"] integerValue];
            self.applyRuleUrl=[req.m_data objectForKey:@"url"];
            if (self.applyStatus==1)//通过
            {
                self.topbg.hidden=NO;
                [self setupHeader];
                [self setupFooter];
                [self updateData];
            }
            else if (self.applyStatus==-1||self.applyStatus==-2||self.applyStatus==-3)//未提交审核,违规跳单,权限取消
            {
                self.topbg.hidden=YES;
                [self.refreshFooter removeFromSuperview];
                [self.refreshHeader removeFromSuperview];
                [self.m_tableView reloadData];
            }
            else if (self.applyStatus==0)//待审核
            {
                self.topbg.hidden=YES;
                [self.refreshFooter removeFromSuperview];
                [self.refreshHeader removeFromSuperview];
                [self.m_tableView reloadData];
            }
            else if (self.applyStatus==2)//拒绝
            {
                self.topbg.hidden=YES;
                [self.refreshFooter removeFromSuperview];
                [self.refreshHeader removeFromSuperview];
                [self.m_tableView reloadData];
            }
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
-(void)clearGrabNewMessage
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"main/clearPointInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
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
-(void)showGrabOrderRules
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=self.rulesUrl;
    vc.title=@"抢单规则";
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)getRulesAndGrabList
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grap/getRollSuccDemandList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
//    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.rulesUrl=[req.m_data objectForKey:@"ruleUrl"];
            [self.m_aryGrabedList removeAllObjects];
            [self.m_aryGrabedList addObjectsFromArray:[req.m_data objectForKey:@"rollSuccDemands"]];
            [self scrollGrabedOrders];
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
-(void)scrollGrabedOrders
{
    if (self.m_aryGrabedList.count==0)
    {
        self.labelGrab1.alpha=0;
        self.labelGrab2.alpha=0;
    }
    else if (self.m_aryGrabedList.count==1)
    {
        self.labelGrab1.alpha=1;
        self.labelGrab2.alpha=0;
        self.labelGrab1.text=[[self.m_aryGrabedList objectAtIndex:0] objectForKey:@"info"];
    }
    else if (self.m_aryGrabedList.count>1)
    {
        self.labelGrab1.alpha=1;
        self.labelGrab2.alpha=0;
        [self showScrollGrabedList];
    }
}
-(void)showScrollGrabedList
{
    if (self.isPoped==YES)
    {
        return;
    }
    if (self.grabedIndex>=self.m_aryGrabedList.count)
    {
        self.grabedIndex=0;
    }
    self.labelGrab1.text=[[self.m_aryGrabedList objectAtIndex:self.grabedIndex] objectForKey:@"info"];
    self.grabedIndex++;
    
    if (self.grabedIndex>=self.m_aryGrabedList.count)
    {
        self.grabedIndex=0;
    }
    self.labelGrab2.text=[[self.m_aryGrabedList objectAtIndex:self.grabedIndex] objectForKey:@"info"];
    self.grabedIndex++;
    
    if (self.labelGrab1.alpha==1)
    {
        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionLayoutSubviews animations:^
         {
             self.labelGrab1.alpha=0;
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^
              {
                  self.labelGrab2.alpha=1;
              } completion:^(BOOL finished)
              {
                  [self performSelector:@selector(showScrollGrabedList) withObject:nil afterDelay:3];
              }];
         }];
    }
    else
    {
        [UIView animateWithDuration:0.3 delay:3 options:UIViewAnimationOptionLayoutSubviews animations:^
         {
             self.labelGrab2.alpha=0;
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^
              {
                  self.labelGrab1.alpha=1;
              } completion:^(BOOL finished)
              {
                  [self performSelector:@selector(showScrollGrabedList) withObject:nil afterDelay:3];
              }];
         }];
    }
    
}
-(void)updateData
{
    if (self.type==0)
    {
        Http *req=[[Http alloc] init];
        req.socialMethord=@"grap/getMyNewDemandList.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"mobile",@"pageindex",@"pagesize"]];
        [self showLoadingWithBG];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                if (self.pageIndex==1)
                {
                    [self.m_aryData removeAllObjects];
                }
                [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"datas"]];
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
            [self.refreshHeader endRefreshing];
            [self.refreshFooter endRefreshing];
        }];
    }
    else
    {
        Http *req=[[Http alloc] init];
        req.socialMethord=@"grap/getMyGrapedDemandList.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount],self.licenseType,self.startTime,self.endTime] forKeys:@[@"mobile",@"pageindex",@"pagesize",@"drivetype",@"starttime",@"endtime"]];
        [self showLoadingWithBG];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                if (self.pageIndex==1)
                {
                    [self.m_aryData removeAllObjects];
                }
                [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"datas"]];
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
            [self.refreshHeader endRefreshing];
            [self.refreshFooter endRefreshing];
        }];
    }
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.applyStatus==1)//通过
    {
        return self.m_aryData.count>0?self.m_aryData.count:1;
    }
    else if (self.applyStatus==-3)//权限被取消
    {
        return 1;
    }
    else if (self.applyStatus==-2)//违规
    {
        return 1;
    }
    else if (self.applyStatus==-1)//未提交
    {
        return 1;
    }
    else if (self.applyStatus==0)//审核中
    {
        return 1;
    }
    else if (self.applyStatus==2)//拒绝
    {
        return 1;
    }
    else
    {
        return 0;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.applyStatus==1)//通过
    {
        if (self.m_aryData.count>0)
        {
            if (self.type==0)
            {
                NewOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NewOrderCell"];
                if (cell==nil)
                {
                    cell=[[[NSBundle mainBundle] loadNibNamed:@"NewOrderCell" owner:nil options:nil] objectAtIndex:0];
                    cell.delegate=self;
                }
                cell.data=[self.m_aryData objectAtIndex:indexPath.row];
                [cell updateView];
                return cell;
            }
            else
            {
                GrabedOrderCell *cell=[tableView dequeueReusableCellWithIdentifier:@"GrabedOrderCell"];
                if (cell==nil)
                {
                    cell=[[[NSBundle mainBundle] loadNibNamed:@"GrabedOrderCell" owner:nil options:nil] objectAtIndex:0];
                    cell.delegate=self;
                }
                cell.data=[self.m_aryData objectAtIndex:indexPath.row];
                [cell updateView];
                return cell;
            }
        }
        else
        {
            NoDataCell *cell=[tableView dequeueReusableCellWithIdentifier:@"NoDataCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"NoDataCell" owner:nil options:nil] objectAtIndex:0];
            }
            return cell;
        }
    }
    else if (self.applyStatus==-3)//权限被取消
    {
        ApplyGrabCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ApplyGrabCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ApplyGrabCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.applyType=-3;
        [cell updateView];
        return cell;
    }
    else if (self.applyStatus==-2)//违规被禁
    {
        ApplyGrabCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ApplyGrabCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ApplyGrabCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.applyType=1;
        [cell updateView];
        return cell;
    }
    else if (self.applyStatus==-1)//未提交
    {
        ApplyGrabCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ApplyGrabCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ApplyGrabCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.applyType=0;
        [cell updateView];
        return cell;
    }
    else if (self.applyStatus==0)//审核中
    {
        ApplyCheckingCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ApplyCheckingCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ApplyCheckingCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        return cell;
    }
    else if (self.applyStatus==2)//拒绝
    {
        ApplyGrabCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ApplyGrabCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ApplyGrabCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.applyType=0;
        [cell updateView];
        return cell;
    }
    else
    {
        return [[UITableViewCell alloc] init];
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=0;
    if (self.applyStatus==1)//通过
    {
        if (self.m_aryData.count<=0)
        {
            height=300;
        }
        else
        {
            if (self.type==0)
            {
                height=180;
            }
            else
            {
                height=140;
            }
        }
    }
    else if (self.applyStatus==-3)//违规
    {
        height=220;
    }
    else if (self.applyStatus==-2)//违规
    {
        height=220;
    }
    else if (self.applyStatus==-1)//未提交
    {
        height=220;
    }
    else if (self.applyStatus==0)//审核中
    {
        height=250;
    }
    else if (self.applyStatus==2)//拒绝
    {
        height=220;
    }
    return height;
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
#pragma mark ------- event response ------- top menu
-(IBAction)topMenuBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<2)
    {
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.topLineView setFrame:CGRectMake(btn.tag*160, PARENT_Y(self.topLineView), PARENT_WIDTH(self.topLineView), PARENT_HEIGHT(self.topLineView))];
        } completion:^(BOOL finished) {
            [self setTopMenuLabelColor:btn.tag];
        }];
    }
}
-(void)setTopMenuLabelColor:(NSInteger)index
{
    [self.labelNew setTextColor:[UIColor darkGrayColor]];
    [self.labelGrabbed setTextColor:[UIColor darkGrayColor]];
    switch (index)
    {
        case 0:
            [self.labelNew setTextColor:YCC_Green];
            break;
        case 1:
            [self.labelGrabbed setTextColor:YCC_Green];
            break;
        default:
            break;
    }
    
    self.type=index;
    self.pageIndex=1;
    [self updateData];
}
-(void)grabOrder:(NSDictionary *)orderData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grap/putGrapInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[[orderData objectForKey:@"did"] stringValue]] forKeys:@[@"mobile",@"did"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag=1;
            [self topMenuBtnPressed:btn];
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
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}
-(void)submitCallEventOrderId:(NSString*)orderid
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"grap/putCoachDialingRecord.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],orderid] forKeys:@[@"mobile",@"did"]];
//    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
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
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
    }];
}
#pragma mark ----------// apply cell event response -----------
-(void)applyBtnPressed
{
    [self checkIfNeedUploadInfo];
}
-(void)checkIfNeedUploadInfo
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/checkWhetherShare.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data objectForKey:@"status"] integerValue]==1)//not need upload
            {
                ApplyGrabVC *vc=[[ApplyGrabVC alloc] init];
                vc.delegate=self;
                [self.navigationController pushViewController:vc animated:YES];
            }
            else//need upload
            {
                UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"申请抢单需先完善您的个人资料，是否去完善您的资料？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.tag=11;
                [alert show];
            }
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
#pragma mark --------- alert view delegate -----------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        if (buttonIndex==1)
        {
            EditInfoVC *vc=[[EditInfoVC alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
}
-(void)showApplyRulesWebview
{
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.title=@"如何成为抢单教练";
    vc.urlStr=self.applyRuleUrl;
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
