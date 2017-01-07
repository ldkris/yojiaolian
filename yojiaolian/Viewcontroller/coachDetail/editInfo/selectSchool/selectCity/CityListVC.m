//
//  CityListVC.m
//  yojiaolian
//
//  Created by carcool on 4/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CityListVC.h"
#import "ProvinceCell.h"
#import "CityCell.h"
#import "SearchSchoolVC.h"
#import "EditInfoVC.h"
@interface CityListVC ()

@end

@implementation CityListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"城市";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.provinceIndex=0;
    self.m_aryData=[NSMutableArray array];
    self.m_aryCitys=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64+40, 90, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    self.m_tableView.tag=0;
    
    self.m_tableView2=[[UITableView alloc] initWithFrame:CGRectMake(90, 64+40, Screen_Width-90, Screen_Height-64-40)];
    [self.m_tableView2 setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.m_tableView2 setDelegate:self];
    [self.m_tableView2 setDataSource:self];
    [self.view addSubview:self.m_tableView2];
    [self.m_tableView2 setBackgroundColor:[UIColor whiteColor]];
    self.m_tableView2.tag=1;
    
    [self updateData];
}
-(void)updateData
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"search/searchAreaList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.longitude]] forKeys:@[@"mobile",@"lat",@"lng"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.labelCurrentCity.text=[req.m_data objectForKey:@"curreCity"];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"areas"]];
            
            NSInteger i=0;
            for (NSDictionary *area in self.m_aryData)
            {
                if ([[area objectForKey:@"province"] isEqualToString:[req.m_data objectForKey:@"curreCity"]])
                {
                    self.provinceIndex=i;
                    break;
                }
                i++;
            }
            
            [self.m_aryCitys removeAllObjects];
            [self.m_aryCitys addObjectsFromArray:[[self.m_aryData objectAtIndex:self.provinceIndex] objectForKey:@"citys"]];
            
            [self.m_tableView reloadData];
            [self.m_tableView2 reloadData];
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
    if (tableView.tag==0)
    {
        return self.m_aryData.count;
    }
    else
    {
        return self.m_aryCitys.count;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==0)
    {
        ProvinceCell *cell=[tableView dequeueReusableCellWithIdentifier:@"ProvinceCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"ProvinceCell" owner:nil options:nil] objectAtIndex:0];
        }
        if (self.provinceIndex==indexPath.row)
        {
            [cell setBackgroundColor:[UIColor whiteColor]];
        }
        else
        {
            [cell setBackgroundColor:YCC_GrayBG];
        }
        cell.labelProvince.text=[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"province"];
        return cell;
    }
    else
    {
        CityCell *cell=[tableView dequeueReusableCellWithIdentifier:@"CityCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"CityCell" owner:nil options:nil] objectAtIndex:0];
        }
        cell.labelCity.text=[[self.m_aryCitys objectAtIndex:indexPath.row] objectForKey:@"name"];
        return cell;
    }
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (tableView.tag==0)
    {
        self.provinceIndex=indexPath.row;
        [self.m_aryCitys removeAllObjects];
        [self.m_aryCitys addObjectsFromArray:[[self.m_aryData objectAtIndex:self.provinceIndex] objectForKey:@"citys"]];
        [self.m_tableView reloadData];
        [self.m_tableView2 reloadData];
    }
    else
    {
        SearchSchoolVC *vc=[[SearchSchoolVC alloc] init];
        vc.levelCode=[[self.m_aryCitys objectAtIndex:indexPath.row] objectForKey:@"levelcode"];
        vc.delegate=self;
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
