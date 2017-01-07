//
//  HomeVC.m
//  yojiaolian
//
//  Created by carcool on 10/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//
#import "HomeVC.h"
#import "HomeInfoCell.h"
#import "HomeFuncCell.h"
#import "WelcomeVC.h"
#import "WebViewVC.h"
#import "APService.h"
#import "OrderTrainVC.h"
#import "TeachLogVC.h"
#import "StudyTimeVC.h"
#import "MyIntegralVC.h"
#import "MyPhotosVC.h"
#import "AdvertisementCell.h"
#import "MyIntegralDetailVC.h"
#import "IntegralRankVC.h"
#import "MyGrabOrderVC.h"
#import "MyOrdersVC.h"
#import "OrderTimeVC.h"
#import "VoiceGuideVC.h"
@interface HomeVC ()

@end
//18523829951 123456
@implementation HomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title=@"优车车教练版";
//    [self setRightNaviBtnTitle:@"退出登录"];
//    [self.rightNaviBtn addTarget:self action:@selector(logoutBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.m_aryData=[NSMutableArray array];
    self.m_aryAdver=[NSMutableArray array];
    self.m_aryMessageCount=[NSMutableArray array];
    self.m_aryPhotos=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:[UIColor whiteColor]];
    [self performSelectorOnMainThread:@selector(showWelcomeVC) withObject:nil waitUntilDone:NO];
    [self checkVersion];
    self.infoView.clipsToBounds=YES;
    [self.infoView.layer setCornerRadius:3.0];
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"首页"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"首页"];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController showTabBar];
    
}

-(void)getAdverInfo
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"advertising/getIndexAdvertisingList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [req startWithBlock:^{
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryAdver removeAllObjects];
            [self.m_aryAdver addObjectsFromArray:[req.m_data objectForKey:@"advertisings"]];
            [self getHomeData];
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
-(void)getHomeData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"main/getHomeData.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [req startWithBlock:^{
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.homeData=req.m_data;
            self.m_aryScrollInfo=[NSArray arrayWithArray:[req.m_data objectForKey:@"rollSuccDemands"]];
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
-(void)uploadJPushID
{
    NSLog(@"[APService registrationID] :%@",[APService registrationID]);
    if ([[APService registrationID] isEqualToString:@""]||![[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        return;
    }
    Http *req=[[Http alloc] init];
    AppDelegate *appdelegate=(AppDelegate*)[UIApplication sharedApplication].delegate;
    req.socialMethord=@"certification/putCoachJpush.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[APService registrationID],appdelegate.isEnterprise==YES?@"":@"1"] forKeys:@[@"mobile",@"jpushid",@"type"]];
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
-(void)getMyQRCode
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/getCoachQrcode.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.qrcodeInfo=req.m_data;
            [self creatQRCodeView];
            [self updateQRCodeView];
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

-(void)checkVersion
{
    Http *req=[[Http alloc] init];
    NSDictionary *infoDic = [[NSBundle mainBundle] infoDictionary];
    //version
    NSString *currentVersion = [infoDic objectForKey:@"CFBundleShortVersionString"];
    //build
    //    NSString *currentVersion = [infoDic objectForKey:@"CFBundleVersion"];
    req.socialMethord=@"version/getAppVersion.yo";
    [req setParams:@[currentVersion,@"ios"] forKeys:@[@"versionname",@"platform"]];
    [req startWithBlock:^{
        [self stopLoading];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            if ([[req.m_data objectForKey:@"versionname"] compare:currentVersion options:NSNumericSearch]==NSOrderedDescending)
            {
                if ([[req.m_data objectForKey:@"isforce"] integerValue]!=1)
                {
                    self.trackUrl=[req.m_data objectForKey:@"downloadpath"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"版本更新" message:[req.m_data objectForKey:@"content"] delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"去更新", nil];
                    alert.tag=22;
                    [alert show];
                }
                else//force update
                {
                    self.trackUrl=[req.m_data objectForKey:@"downloadpath"];
                    self.updateContent=[req.m_data objectForKey:@"content"];
                    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"版本更新" message:self.updateContent delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
                    alert.tag=23;
                    [alert show];
                }

            }
            else
            {
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

-(void)creatPageScrollview
{
    self.imagePlayerView=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    
    if (self.screenBlackBG)
    {
        [self.screenBlackBG removeFromSuperview];
        self.screenBlackBG=nil;
    }
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    //bg
    self.screenBlackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.screenBlackBG setBackgroundColor:[UIColor blackColor]];
    [self.screenBlackBG setAlpha:1.0];
    [appdelegate.window addSubview:self.screenBlackBG];
    [self.screenBlackBG addSubview:self.imagePlayerView];
    
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:self.m_aryPhotos.count delegate:self];
    self.imagePlayerView.scrollInterval = 999.0f;
    self.imagePlayerView.autoScroll=NO;
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    self.imagePlayerView.hidePageControl = NO;
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
//    [imageView setWebImageViewWithURL:[NSURL URLWithString:[self.m_aryPhotos objectAtIndex:index]]];
    WebImageViewNormal *webimg=[[WebImageViewNormal alloc] initWithFrame:CGRectMake(0, (Screen_Height-210)/2.0, 320, 210)];
    [webimg setWebImageViewWithURL:[NSURL URLWithString:[self.m_aryPhotos objectAtIndex:index]]];
    [imageView addSubview:webimg];
}

- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    NSLog(@"did tap index = %d", (int)index);
    [self.imagePlayerView removeFromSuperview];
    self.imagePlayerView=nil;
    [self.screenBlackBG removeFromSuperview];
    self.screenBlackBG=nil;
}
#pragma mark -------------- alert view delegate ----------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==22)//更新
    {
        if (buttonIndex==1)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackUrl]];
        }
    }
    else if (alertView.tag==23)//强制更新
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.trackUrl]];
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"版本更新" message:self.updateContent delegate:self cancelButtonTitle:@"立即更新" otherButtonTitles:nil, nil];
        alert.tag=23;
        [alert show];
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [self showWelcomeVC];
    if ([[MyFounctions getUserInfo] objectForKey:@"account"])
    {
//        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
//        if (appdelegate.m_currentLocation.latitude>0)
//        {
            [self getUserInfo];
//        }
        [self uploadJPushID];
    }
}
-(void)getUserInfo
{
//    [self showLoadingWithBG];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/getMyInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.longitude]] forKeys:@[@"mobile",@"lat",@"lng"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.userInfo=req.m_data;
            [self.m_aryPhotos removeAllObjects];
            [self.m_aryPhotos addObjectsFromArray:[self.userInfo objectForKey:@"imgurls"]];
            [self getUndoMessage];
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
-(void)getUndoMessage
{
    //    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"main/getMenuUnHandledHint.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryMessageCount removeAllObjects];
            self.m_aryMessageCount=[NSMutableArray arrayWithArray:[req.m_data objectForKey:@"menus"]];
            [self getGrabNewMessage];
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
-(void)getGrabNewMessage
{
    //    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"main/getNewPointInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            NSUserDefaults *userdefaults=[NSUserDefaults standardUserDefaults];
            [userdefaults setObject:[[req.m_data objectForKey:@"num"] stringValue] forKey:@"grab"];
            [self getAdverInfo];
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
#pragma mark -------- show others VC
-(void)showWelcomeVC
{
    if (![[MyFounctions getUserInfo] objectForKey:@"account"])
    {
        WelcomeVC *vc=[[WelcomeVC alloc] init];
        [self presentViewController:[[YCCNavigationController alloc] initWithRootViewController:vc] animated:NO completion:^{
            
        }];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        AdvertisementCell *cell=[tableView dequeueReusableCellWithIdentifier:@"AdvertisementCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"AdvertisementCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.m_aryData=[NSMutableArray arrayWithArray:self.m_aryAdver];
        [cell updateView];
        return cell;
    }
    else if (indexPath.row==1)
    {
        HomeFuncCell *cell=[[[NSBundle mainBundle] loadNibNamed:@"HomeFuncCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
        cell.m_aryData=[NSMutableArray arrayWithArray:self.m_aryMessageCount];
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
    if (indexPath.row==0)
    {
        height=310;
    }
    else if (indexPath.row==1)
    {
        height=330;
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row==0)
//    {
//        AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
//        [appdelegate.tabBarController hideTabBar];
//        MyPhotosVC *vc=[[MyPhotosVC alloc] init];
//        vc.userInfo=[NSDictionary dictionaryWithDictionary:self.userInfo];
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ----------- post pic cell protacal ---------
-(void)showScreenViewForAvatar:(UIImage *)img
{
    if (self.screenBlackBG)
    {
        [self.screenBlackBG removeFromSuperview];
        self.screenBlackBG=nil;
        [self.bigView removeFromSuperview];
        self.bigView=nil;
    }
    
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    //bg
    self.screenBlackBG=[[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.screenBlackBG setBackgroundColor:[UIColor blackColor]];
    [self.screenBlackBG setAlpha:1.0];
    [appdelegate.window addSubview:self.screenBlackBG];
    
    self.bigView=[[VIPhotoView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, Screen_Height) andImage:img];
    self.bigView.autoresizingMask = (1 << 6) -1;
    [appdelegate.window addSubview:self.bigView];
    
    
    UIButton *btnRemoveSexView=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnRemoveSexView setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btnRemoveSexView addTarget:self action:@selector(removeSexBG) forControlEvents:UIControlEventTouchUpInside];
    [self.bigView addSubview:btnRemoveSexView];
}
-(void)removeSexBG
{
    [self.screenBlackBG removeFromSuperview];
    self.screenBlackBG=nil;
    [self.bigView removeFromSuperview];
    self.bigView=nil;
}

#pragma mark ---------- event response -----------------
-(IBAction)logoutBtnPressed:(id)sender
{
    [MyFounctions removeUserInfo];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.m_homeVC showWelcomeVC];
}
-(void)funcBtnPressed:(NSInteger)index
{
    
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=[NSString stringWithFormat:@"%@%@",[[self.m_aryData objectAtIndex:index] objectForKey:@"skipurl"],[[MyFounctions getUserInfo] objectForKey:@"coachid"]];
    vc.title=[[self.m_aryData objectAtIndex:index] objectForKey:@"name"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showOrderTrainVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    
    OrderTrainVC *vc=[[OrderTrainVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showTrainRecordsListVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    
    TeachLogVC *vc=[[TeachLogVC alloc] init];
    vc.title=@"练车记录";
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showStudyTimeVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    
    StudyTimeVC *vc=[[StudyTimeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)creatQRCodeView
{
    [self addBlackBGViewOnKeywindow];
    [self.infoView setFrame:CGRectMake(30, (Screen_Height-PARENT_HEIGHT(self.infoView))/2.0, PARENT_WIDTH(self.infoView), PARENT_HEIGHT(self.infoView))];
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
    [appdelegate.window addSubview:self.infoView];
    
    self.btnRemove=[UIButton buttonWithType:UIButtonTypeCustom];
    [self.btnRemove setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [self.btnRemove addTarget:self action:@selector(removeQRCodeView) forControlEvents:UIControlEventTouchUpInside];
    [appdelegate.window addSubview:self.btnRemove];
}
-(void)removeQRCodeView
{
    [self.btnRemove removeFromSuperview];
    self.btnRemove=nil;
    [self.infoView removeFromSuperview];
    [self removeBLackBGView];
}
-(void)updateQRCodeView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.qrcodeInfo objectForKey:@"headimgurl"]]];
    [self.qrcodeImg setWebImageViewWithURL:[NSURL URLWithString:[self.qrcodeInfo objectForKey:@"qrcode"]]];
    self.labelName.text=[self.qrcodeInfo objectForKey:@"name"];
    if ([[self.qrcodeInfo objectForKey:@"type"] integerValue]==1)
    {
        self.labelClass.text=@"科目一";
    }
    else if ([[self.qrcodeInfo objectForKey:@"type"] integerValue]==2)
    {
        self.labelClass.text=@"科目二";
    }
    else if ([[self.qrcodeInfo objectForKey:@"type"] integerValue]==3)
    {
        self.labelClass.text=@"科目三";
    }
}

-(void)showIntegralVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    MyIntegralDetailVC *vc=[[MyIntegralDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showAdverInfoVC:(NSString*)adverUrl adverTitle:(NSString*)title shareData:(NSDictionary *)shareData
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    if ([adverUrl isEqualToString:@""])
    {
        IntegralRankVC *vc=[[IntegralRankVC alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        WebViewVC *vc=[[WebViewVC alloc] init];
        vc.urlStr=adverUrl;
        vc.title=title;
        vc.shareData=[NSDictionary dictionaryWithDictionary:shareData];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
-(void)showMyGrabOrederVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    MyGrabOrderVC *vc=[[MyGrabOrderVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showMyOrdersVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    MyOrdersVC *vc=[[MyOrdersVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showOrderTimeVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    OrderTimeVC *vc=[[OrderTimeVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showCoachDetail
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController btn2Pressed];
}
-(void)showVoiceIntraduction
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    VoiceGuideVC *vc=[[VoiceGuideVC alloc] init];
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
