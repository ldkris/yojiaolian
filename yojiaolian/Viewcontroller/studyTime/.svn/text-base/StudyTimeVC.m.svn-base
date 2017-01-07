//
//  StudyTimeVC.m
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "StudyTimeVC.h"
#import "StudyTimeCell.h"
#import "FiltrateOrderVC.h"
#import "StudyTimeDetailVC.h"
@interface StudyTimeVC ()

@end

@implementation StudyTimeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"学时统计";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnImage:[UIImage imageNamed:@"search_orderTrain"]];
    [self.rightNaviBtn addTarget:self action:@selector(showFiltrateVC) forControlEvents:UIControlEventTouchUpInside];
    self.m_aryData=[NSMutableArray array];
    self.m_aryDataTotal=[NSMutableArray array];
    self.filtrateData=[NSMutableDictionary dictionaryWithObjects:@[@"",@"",@"",@""] forKeys:@[@"studentname",@"teachingitem",@"starttime",@"endtime"]];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64+45, Screen_Width, Screen_Height-64-45)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    [self setupHeader];
    [self setupFooter];
    
    
    [self updateData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"学时统计"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"学时统计"];
}

-(void)showFiltrateVC
{
    FiltrateOrderVC *vc=[[FiltrateOrderVC alloc] init];
    vc.type=3;//study statics
    vc.title=@"学时统计查询";
    vc.m_aryOperate=[NSMutableArray arrayWithObjects:@"科目二",@"科目三", nil];
    vc.data=[NSMutableDictionary dictionaryWithObjects:@[@"",@"1",@"",@""] forKeys:@[@"studentname",@"status",@"starttime",@"endtime"]];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    NSMutableArray *aryParams=[NSMutableArray arrayWithArray:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%d",self.pageIndex],[NSString stringWithFormat:@"%d",self.pageCount]]];
    NSMutableArray *aryKeys=[NSMutableArray arrayWithArray:@[@"mobile",@"pageindex",@"pagesize"]];
    for (NSString *key in [self.filtrateData allKeys])
    {
        [aryKeys addObject:key];
        [aryParams addObject:[self.filtrateData objectForKey:key]];
    }

    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"statistical/getStudentPeriodStatisticalList.yo";
    [req setParams:aryParams forKeys:aryKeys];
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
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"studentPeriods"]];
            [self.m_tableView reloadData];
            
//            [self.m_aryDataTotal removeAllObjects];
//            [self.m_aryDataTotal addObjectsFromArray:[req.m_data objectForKey:@"datas"]];
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
#pragma mark --------- filtrate delegate ----------
-(void)filtrateBtnPressed:(NSDictionary *)dic
{
    [self.filtrateData setObject:[dic objectForKey:@"studentname"] forKey:@"studentname"];
    [self.filtrateData setObject:[NSString stringWithFormat:@"%d",[[dic objectForKey:@"status"] integerValue]+1] forKey:@"teachingitem"];
    [self.filtrateData setObject:[dic objectForKey:@"starttime"] forKey:@"starttime"];
    [self.filtrateData setObject:[dic objectForKey:@"endtime"] forKey:@"endtime"];
    self.pageIndex=1;
    [self updateData];
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

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count>0?self.m_aryData.count:1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        StudyTimeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"StudyTimeCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"StudyTimeCell" owner:nil options:nil] objectAtIndex:0];
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
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.m_aryData.count>0)
    {
        return 50;
    }
    else
    {
        return 300;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.m_aryData.count>0)
    {
        StudyTimeDetailVC *vc=[[StudyTimeDetailVC alloc] init];
        vc.preData=[self.m_aryData objectAtIndex:indexPath.row];
        [self.navigationController pushViewController:vc animated:YES];
    }
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
