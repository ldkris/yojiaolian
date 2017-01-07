//
//  OrderTrainVC.m
//  yojiaolian
//
//  Created by carcool on 10/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderTrainVC.h"
#import "FiltrateOrderVC.h"
#import "OrderTrainDoneCell.h"
#import "OrderTrainUndo.h"
#import "OrderTrainDetailVC.h"
@interface OrderTrainVC ()

@end

@implementation OrderTrainVC
@synthesize m_scrollView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"预约练车";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnImage:[UIImage imageNamed:@"search_orderTrain"]];
    [self.rightNaviBtn addTarget:self action:@selector(showFiltrateVC) forControlEvents:UIControlEventTouchUpInside];
    self.rightNaviBtn.hidden=YES;
    self.topLineView=[[UIView alloc] initWithFrame:CGRectMake(50,43, 60, 2)];
    [self.topLineView setBackgroundColor:YCC_Green];
    [self.topLineView.layer setCornerRadius:1.0];
    [self.topbg addSubview:self.topLineView];
    [self.topbg setBackgroundColor:[UIColor whiteColor]];
    [self.topbg.layer setBorderWidth:1.0];
    [self.topbg.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.labelUndo setTextColor:YCC_Green];
    [self.labelDone setTextColor:YCC_TextColor];
    [self.doneSectionLineView0 setBackgroundColor:YCC_GrayBG];
    
    self.operateType=0;
    self.pageCount=10;
    self.pageIndexSocial=1;
    self.pageCountSocial=10;
    self.m_aryData=[NSMutableArray array];
    self.m_aryDataSocial=[NSMutableArray array];
    self.filtrateData=[NSMutableDictionary dictionaryWithObjects:@[@"",@"",@"",@""] forKeys:@[@"studentname",@"status",@"starttime",@"endtime"]];
    [self createScrollView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"预约练车"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"预约练车"];
}
-(void)reloadAllData
{
    self.pageIndex=1;
    self.pageIndexSocial=1;
    [self updateData];
    [self updateDataForSocial];
}
#pragma mark ---------- create views -------------------
-(void)createScrollView
{
    self.m_scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, 64+45, Screen_Width, Screen_Height-64-45)];
    self.m_scrollView.bounces=NO;
    self.m_scrollView.delegate=self;
    self.m_scrollView.tag=11;
    [m_scrollView setContentSize:CGSizeMake(Screen_Width*2, Screen_Height-64-45)];
    m_scrollView.showsHorizontalScrollIndicator=NO;
    m_scrollView.pagingEnabled=YES;
    [m_scrollView setBackgroundColor:YCC_GrayBG];
    self.m_scrollView.scrollEnabled=YES;
    [self.view addSubview:self.m_scrollView];
    
    self.m_tableView=[[UITableView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, PARENT_HEIGHT(self.m_scrollView))];
    self.m_tableView.tag=0;
    [self.m_tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self.m_tableView setDelegate:self];
    [self.m_tableView setDataSource:self];
    [self.m_scrollView addSubview:self.m_tableView];
    
    [self setupHeader];
    [self setupFooter];
    [self updateData];
    [self updateDataForSocial];
    
    self.m_tableviewSocial=[[UITableView alloc] initWithFrame:CGRectMake(Screen_Width, 0, Screen_Width, PARENT_HEIGHT(self.m_scrollView))];
    self.m_tableviewSocial.tag=1;
    [self.m_tableviewSocial setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.m_tableviewSocial setBackgroundColor:YCC_GrayBG];
    [self.m_tableviewSocial setDelegate:self];
    [self.m_tableviewSocial setDataSource:self];
    [self.m_scrollView addSubview:self.m_tableviewSocial];
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag==0)
    {
        return self.m_aryData.count>0?self.m_aryData.count:1;
    }
    else
    {
        return self.m_aryDataSocial.count>0?self.m_aryDataSocial.count:1;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        if (self.m_aryData.count>0)
        {
            OrderTrainUndo *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTrainUndo"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTrainUndo" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            cell.data=[self.m_aryData objectAtIndex:indexPath.row];
            [cell updateView];
            return cell;
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
    else
    {
        if (self.m_aryDataSocial.count>0)
        {
            OrderTrainDoneCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTrainDoneCell"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTrainDoneCell" owner:nil options:nil] objectAtIndex:0];
            }
            cell.data=[self.m_aryDataSocial objectAtIndex:indexPath.row];
            [cell updateView];
            return cell;
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
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag==0)
    {
        if (self.m_aryData.count>0)
        {
            return 230;
        }
        else
        {
            return 300;
        }
    }
    else
    {
        if (self.m_aryDataSocial.count>0)
        {
            return 50;
        }
        else
        {
            return 300;
        }
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag==1&&self.m_aryDataSocial.count>0)
    {
        OrderTrainDetailVC *vc=[[OrderTrainDetailVC alloc] init];
        vc.preData=[self.m_aryDataSocial objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return self.doneSectionView;
    }
    else
    {
        return nil;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag==1)
    {
        return 55.0;
    }
    else
    {
        return 0;
    }
}
#pragma  mark ------ refresh delegate
-(void)headerRefresh
{
    if (self.operateType==0)
    {
        self.pageIndex=1;
        [self updateData];
    }
    else
    {
        self.pageIndexSocial=1;
        [self updateDataForSocial];
    }
    
}
-(void)footerRefresh
{
    if (self.operateType==0)
    {
        self.pageIndex++;
        [self updateData];
    }
    else
    {
        self.pageIndexSocial++;
        [self updateDataForSocial];
    }
}

#pragma mark ======= scroll delegate==============
//UIScrollViewDelegate方法
- (void)scrollViewDidEndDecelerating:(UIScrollView *)sView
{
    if (sView.tag==11)
    {
        NSInteger index = fabs(sView.contentOffset.x) / sView.frame.size.width;
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.topLineView setFrame:CGRectMake(index*160+50, PARENT_Y(self.topLineView), PARENT_WIDTH(self.topLineView), PARENT_HEIGHT(self.topLineView))];
        } completion:^(BOOL finished) {
            [self setTopMenuLabelColor:index];
            self.operateType=index;
            if (self.operateType==0)
            {
                [self.refreshHeader addToScrollView:self.m_tableView];
                [self.refreshFooter addToScrollView:self.m_tableView];
            }
            else
            {
                [self.refreshHeader addToScrollView:self.m_tableviewSocial];
                [self.refreshFooter addToScrollView:self.m_tableviewSocial];
            }
        }];
    }
}
#pragma mark --------- filtrate delegate ----------
-(void)filtrateBtnPressed:(NSDictionary *)dic
{
    switch ([[dic objectForKey:@"status"] integerValue])
    {
        case 1:
            [self.filtrateData setObject:@"1" forKey:@"status"];
            break;
        case 2:
            [self.filtrateData setObject:@"2" forKey:@"status"];
            break;
        case 3:
            [self.filtrateData setObject:@"4" forKey:@"status"];
            break;
        case 4:
            [self.filtrateData setObject:@"5" forKey:@"status"];
            break;
        case 5:
            [self.filtrateData setObject:@"8" forKey:@"status"];
            break;
        default:
            break;
    }
    [self.filtrateData setObject:[dic objectForKey:@"studentname"] forKey:@"studentname"];
    [self.filtrateData setObject:[dic objectForKey:@"starttime"] forKey:@"starttime"];
    [self.filtrateData setObject:[dic objectForKey:@"endtime"] forKey:@"endtime"];
    self.pageIndexSocial=1;
    [self updateDataForSocial];
}
#pragma mark ------- event response ------- top menu
-(IBAction)topMenuBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    if (btn.tag<2)
    {
        [self.m_scrollView scrollRectToVisible:CGRectMake(Screen_Width*btn.tag, 0, 320, Screen_Height-64-49) animated:YES];
        [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            [self.topLineView setFrame:CGRectMake(50+btn.tag*160, PARENT_Y(self.topLineView), PARENT_WIDTH(self.topLineView), PARENT_HEIGHT(self.topLineView))];
        } completion:^(BOOL finished) {
            [self setTopMenuLabelColor:btn.tag];
            self.operateType=btn.tag;
            if (self.operateType==0)
            {
                [self.refreshHeader addToScrollView:self.m_tableView];
                [self.refreshFooter addToScrollView:self.m_tableView];
            }
            else
            {
                [self.refreshHeader addToScrollView:self.m_tableviewSocial];
                [self.refreshFooter addToScrollView:self.m_tableviewSocial];
            }
        }];
    }
}
-(void)setTopMenuLabelColor:(NSInteger)index
{
    [self.labelDone setTextColor:YCC_TextColor];
    [self.labelUndo setTextColor:YCC_TextColor];
    switch (index)
    {
        case 0:
            [self.labelUndo setTextColor:YCC_Green];
            self.rightNaviBtn.hidden=YES;
            break;
        case 1:
            [self.labelDone setTextColor:YCC_Green];
            self.rightNaviBtn.hidden=NO;
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData//未处理
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getUnhandledStudentAppointList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]] forKeys:@[@"mobile",@"pageindex",@"pagesize"]];
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
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"studentappoints"]];
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
-(void)updateDataForSocial
{
    NSMutableArray *aryParams=[NSMutableArray arrayWithArray:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndexSocial],[NSString stringWithFormat:@"%d",self.pageCountSocial]]];
    NSMutableArray *aryKeys=[NSMutableArray arrayWithArray:@[@"mobile",@"pageindex",@"pagesize"]];
    for (NSString *key in [self.filtrateData allKeys])
    {
        [aryKeys addObject:key];
        [aryParams addObject:[self.filtrateData objectForKey:key]];
    }
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getHandledStudentAppointList.yo";
    [req setParams:aryParams forKeys:aryKeys];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        [self.refreshHeader endRefreshing];
        [self.refreshFooter endRefreshing];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if (self.pageIndexSocial==1)
            {
                [self.m_aryDataSocial removeAllObjects];
            }
            [self.m_aryDataSocial addObjectsFromArray:[req.m_data objectForKey:@"studentappoints"]];
            [self.m_tableviewSocial reloadData];
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

-(void)showFiltrateVC
{
    FiltrateOrderVC *vc=[[FiltrateOrderVC alloc] init];
    vc.title=@"练车预约查询";
    vc.m_aryOperate=[NSMutableArray arrayWithObjects:@"同意预约",@"拒绝预约",@"同意取消",@"拒绝取消",@"过期未处理", nil];
    vc.data=[NSMutableDictionary dictionaryWithObjects:@[@"",@"1",@"",@""] forKeys:@[@"studentname",@"status",@"starttime",@"endtime"]];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)agreeOrder:(NSString*)orderid type:(NSString*)type//1:order 3:cancel
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/putAuditStudentAppoint.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],orderid,type,@""] forKeys:@[@"mobile",@"appointid",@"status",@"reason_desc"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self showMessage:@"已同意"];
            self.pageIndex=1;
            [self updateData];
            self.pageIndexSocial=1;
            [self updateDataForSocial];
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
