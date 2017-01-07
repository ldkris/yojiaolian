//
//  SettingVC.m
//  yojiaolian
//
//  Created by carcool on 10/28/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SettingVC.h"
#import "SettingCell.h"
#import "AboutUsVC.h"
#import "MyIntegralVC.h"
#import "MyPhotosVC.h"
#import "HomeVC.h"
#import "MobClick.h"
#import "MyIntegralDetailVC.h"
#import "SettingPageCell.h"
#import "EditInfoVC.h"
@interface SettingVC ()

@end

@implementation SettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"设置";
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"设置"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"设置"];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController showTabBar];
    //    self.navigationController.navigationBar.hidden=YES;
    
    [self updateData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/getMyBaseInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
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
-(void)unbundleJpush
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/putMyUnbunding.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [MobClick profileSignOff];
            [MyFounctions removeUserInfo];
            AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
            [appdelegate.m_homeVC showWelcomeVC];
            appdelegate.m_coachDetailVC.isNeedUploadInfo=YES;
            appdelegate.m_coachDetailVC.haveCoachInfo=NO;
            appdelegate.m_coachDetailVC.haveCheckInfo=NO;
            appdelegate.m_coachDetailVC.coachData=[NSDictionary dictionary];
            appdelegate.m_coachDetailVC.m_aryFees=[NSMutableArray array];
            appdelegate.m_coachDetailVC.m_aryTags=[NSMutableArray array];
            appdelegate.m_coachDetailVC.m_aryShowed=[NSMutableArray array];
            [appdelegate.m_coachDetailVC.m_tableView reloadData];
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
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingPageCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SettingPageCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SettingPageCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=self.data;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 320;
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
#pragma mark -------- event response --------------
-(void)showEditPhotoVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    MyPhotosVC *vc=[[MyPhotosVC alloc] init];
    vc.userInfo=[NSDictionary dictionaryWithDictionary:appdelegate.m_homeVC.userInfo];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showIntegralDetailVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    MyIntegralDetailVC *vc=[[MyIntegralDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showAboutUsVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    AboutUsVC *vc=[[AboutUsVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)logoutBtnPressed
{
    [self unbundleJpush];
}
-(void)showEditInfoVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    EditInfoVC *vc=[[EditInfoVC alloc] init];
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
