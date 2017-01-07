//
//  CoachDetailVC.m
//  yojiaolian
//
//  Created by carcool on 4/7/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CoachDetailVC.h"
#import "EditInfoVC.h"
#import "CoachDetailCellPhoto.h"
#import "CoachDetailCellInfo.h"
#import "CoachDetailCellFee.h"
#import "CoachDetailCellTagTitle.h"
#import "CoachDetailCellTags.h"
#import "CoachDetailCellSpace.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "WebViewVC.h"
@interface CoachDetailVC ()

@end

@implementation CoachDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"我的招生页";
    [self setLeftNaviBtnTitle:@"编辑"];
    [self.leftNaviBtn addTarget:self action:@selector(showEditInfoVC) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnImage:[UIImage imageNamed:@"share_post"]];
    [self.rightNaviBtn addTarget:self action:@selector(topRightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    
    self.isNeedUploadInfo=YES;
    self.haveCoachInfo=NO;
    self.haveCheckInfo=NO;
    self.coachData=[NSDictionary dictionary];
    self.m_aryFees=[NSMutableArray array];
    self.m_aryTags=[NSMutableArray array];
    self.m_aryShowed=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-49)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self.noteShareView setFrame:CGRectMake(20, (Screen_Height-250)/2.0, 280, 250)];
    [self.noteShareView setClipsToBounds:YES];
    [self.noteShareView.layer setCornerRadius:5.0];
    [self.noteClickGoodView setFrame:CGRectMake(20, (Screen_Height-250)/2.0, 280, 250)];
    [self.noteClickGoodView setClipsToBounds:YES];
    [self.noteClickGoodView.layer setCornerRadius:5.0];
    self.haveShowedNoteShare=NO;
    self.shareFromNote=0;
}
-(void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController showTabBar];

}
-(void)viewDidAppear:(BOOL)animated
{
    if (self.haveCoachInfo==NO)
    {
        [self checkIfNeedUploadInfo];
    }
    else
    {
        [self updateData];
    }
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/getMyCard.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.coachData=[NSDictionary dictionaryWithDictionary:req.m_data];
            [self.m_aryFees removeAllObjects];
            [self.m_aryFees addObjectsFromArray:[req.m_data objectForKey:@"fees"]];
            [self.m_aryTags removeAllObjects];
            [self.m_aryTags addObjectsFromArray:[req.m_data objectForKey:@"tags"]];
            
            //showed array
            [self.m_aryShowed removeAllObjects];
            if ([(NSArray*)[self.coachData objectForKey:@"imgurls"] count]>0)
            {
                [self.m_aryShowed addObject:@"photo"];
            }
            [self.m_aryShowed addObject:@"info"];
            for (NSDictionary *dic in self.m_aryFees)
            {
                [self.m_aryShowed addObject:@"fee"];
            }
            [self.m_aryShowed addObject:@"tagTitle"];
            [self.m_aryShowed addObject:@"tags"];
            [self.m_aryShowed addObject:@"space"];
            [self.m_tableView reloadData];
            
            //show note share
            if (self.haveShowedNoteShare==NO&&self.haveCoachInfo==YES)
            {
                [self getShareNoteData];
                self.haveShowedNoteShare=YES;
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
-(void)getShareNoteData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/getCoachLikeInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.shareNoteData=req.m_data;
            if ([[self.shareNoteData objectForKey:@"likeNum"] integerValue]>0)
            {
                [self showNoteShareView];
            }
            else
            {
                [self showNoteClickGoodView];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
            if ([[req.m_data objectForKey:@"status"] integerValue]==1)
            {
                self.isNeedUploadInfo=NO;
                self.haveCoachInfo=YES;
            }
            else
            {
                self.isNeedUploadInfo=YES;
                self.haveCoachInfo=NO;
            }
            if (self.isNeedUploadInfo==YES)
            {
                if (self.haveCheckInfo==NO)
                {
                    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.tabBarController hideTabBar];
                    EditInfoVC *vc=[[EditInfoVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            else
            {
                [self updateData];
            }
            self.haveCheckInfo=YES;
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
    return self.haveCoachInfo==NO?1:self.m_aryShowed.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.haveCoachInfo==NO)
    {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
        [cell setBackgroundColor:[UIColor clearColor]];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        UILabel *labelDescrip=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
        labelDescrip.text=@"请先完善个人资料";
        labelDescrip.textAlignment=NSTextAlignmentCenter;
        [labelDescrip setTextColor:[UIColor darkGrayColor]];
        [labelDescrip setFont:[UIFont systemFontOfSize:14.0]];
        [cell addSubview:labelDescrip];
        return cell;
    }
    else
    {
        if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"photo"])
        {
            CoachDetailCellPhoto *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachDetailCellPhoto"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCellPhoto" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            [cell updateViews];
            return cell;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"info"])
        {
            CoachDetailCellInfo *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachDetailCellInfo"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCellInfo" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            [cell updateViews];
            return cell;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"fee"])
        {
            CoachDetailCellFee *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachDetailCellFee"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCellFee" owner:nil options:nil] objectAtIndex:0];
                
            }
            NSInteger index=indexPath.row-1-([[self.m_aryShowed objectAtIndex:0] isEqualToString:@"photo"]?1:0);
            cell.data=[self.m_aryFees objectAtIndex:index];
            [cell updateView];
            return cell;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tagTitle"])
        {
            CoachDetailCellTagTitle *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachDetailCellTagTitle"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCellTagTitle" owner:nil options:nil] objectAtIndex:0];
            }
            return cell;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tags"])
        {
            CoachDetailCellTags *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachDetailCellTags"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCellTags" owner:nil options:nil] objectAtIndex:0];
            }
            cell.m_aryData=[NSMutableArray arrayWithArray:self.m_aryTags];
            [cell updateView];
            return cell;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"space"])
        {
            CoachDetailCellSpace *cell=[tableView dequeueReusableCellWithIdentifier:@"CoachDetailCellSpace"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"CoachDetailCellSpace" owner:nil options:nil] objectAtIndex:0];
            }
            [cell.spaceImg setWebImageViewWithURL:[NSURL URLWithString:[self.coachData objectForKey:@"spaceUrl"]]];
            return cell;
        }
        else
        {
            return [[UITableViewCell alloc] init];
        }
        
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    float height=40;
    if (self.haveCoachInfo==NO)
    {
        height= 60;
    }
    else
    {
        if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"photo"])
        {
            height=210;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"info"])
        {
            height=110;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"fee"])
        {
            height=40;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tagTitle"])
        {
            height=30;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tags"])
        {
            height=40*(self.m_aryTags.count/4+(self.m_aryTags.count%4>0?1:0));
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"space"])
        {
            height=220;
        }
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
#pragma mark -------- event response ----------
-(void)topRightBtnPressed
{
    self.shareFromNote=0;
    [self shareCoachDetail];
}
-(void)showEditInfoVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    [appdelegate.tabBarController hideTabBar];
    EditInfoVC *vc=[[EditInfoVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)shareCoachDetail
{
    if (self.haveCoachInfo==NO)
    {
        [self showMessage:@"请先编辑个人资料"];
        return;
    }
    else//share
    {
        Http *req=[[Http alloc] init];
        req.socialMethord=@"my/putMyShare.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"1"] forKeys:@[@"mobile",@"shareto"]];
        [self showLoadingWithBG];
        [req startWithBlock:^{
            [self stopLoadingWithBG];
            if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
            {
                //1、创建分享参数
                NSArray* imageArray = @[[req.m_data objectForKey:@"headimgurl"]];
                //        （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
                if (imageArray)
                {
                    
                    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
                    if (self.shareFromNote==0)//topright share
                    {
                        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"我是%@, 找我学车有优惠，想学车的朋友快来找我哟",[self.coachData objectForKey:@"name"]]
                                                         images:imageArray
                                                            url:[NSURL URLWithString:[req.m_data objectForKey:@"shareurl"]]
                                                          title:[NSString stringWithFormat:@"%@的招生页",[self.coachData objectForKey:@"name"]]
                                                           type:SSDKContentTypeAuto];
                    }
                    else//note card
                    {
                        NSString *strTitle=@"";                        if ([[self.coachData objectForKey:@"dsname"] isEqualToString:@"其他驾校"])
                        {
                            strTitle=[NSString stringWithFormat:@"我是%@",[self.coachData objectForKey:@"name"]];
                        }
                        else
                        {
                            strTitle=[NSString stringWithFormat:@"我是%@的%@",[self.coachData objectForKey:@"dsname"],[self.coachData objectForKey:@"name"]];
                        }
                        [shareParams SSDKSetupShareParamsByText:[NSString stringWithFormat:@"我是%@, 已获得%d次学员点赞,打败了%d％的教练",[self.coachData objectForKey:@"name"],[[self.coachData objectForKey:@"goodNum"] integerValue],[[self.shareNoteData objectForKey:@"topNum"] integerValue]]
                                                         images:imageArray
                                                            url:[NSURL URLWithString:[req.m_data objectForKey:@"shareurl"]]
                                                          title:strTitle
                                                           type:SSDKContentTypeAuto];
                    }
                    //2、分享（可以弹出我们的分享菜单和编辑界面）
                    [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                             items:nil
                                       shareParams:shareParams
                               onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                                   
                                   switch (state) {
                                       case SSDKResponseStateSuccess:
                                       {
                                           UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                               message:nil
                                                                                              delegate:nil
                                                                                     cancelButtonTitle:@"确定"
                                                                                     otherButtonTitles:nil];
                                           [alertView show];
                                           break;
                                       }
                                       case SSDKResponseStateFail:
                                       {
                                           UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                                           message:[NSString stringWithFormat:@"%@",error]
                                                                                          delegate:nil
                                                                                 cancelButtonTitle:@"OK"
                                                                                 otherButtonTitles:nil, nil];
                                           [alert show];
                                           break;
                                       }
                                       default:
                                           break;
                                   }
                               }  
                     ];}
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
    
}
-(void)showNoteShareView
{
    self.labelGoodNum.text=[NSString stringWithFormat:@"已有%d位学员",[[self.shareNoteData objectForKey:@"likeNum"] integerValue]];
    self.labelDefeat.text=[NSString stringWithFormat:@"%d％",[[self.shareNoteData objectForKey:@"topNum"] integerValue]];
    [self addBlackBGViewOnKeywindow];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btn addTarget:self action:@selector(removeNoteShareViewAndBlackBG) forControlEvents:UIControlEventTouchUpInside];
    [self.blackBG addSubview:btn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.noteShareView];
}
-(void)removeNoteShareViewAndBlackBG
{
    [self.noteShareView removeFromSuperview];
    [self removeBLackBGView];
}
-(IBAction)noteShareBtnPressed:(id)sender
{
    [self removeNoteShareViewAndBlackBG];
    self.shareFromNote=1;
    [self shareCoachDetail];
}
-(void)showNoteClickGoodView
{
    [self addBlackBGViewOnKeywindow];
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setFrame:CGRectMake(0, 0, Screen_Width, Screen_Height)];
    [btn addTarget:self action:@selector(removeNoteClickGoodViewAndBlackBG) forControlEvents:UIControlEventTouchUpInside];
    [self.blackBG addSubview:btn];
    [[UIApplication sharedApplication].keyWindow addSubview:self.noteClickGoodView];
}
-(void)removeNoteClickGoodViewAndBlackBG
{
    [self.noteClickGoodView removeFromSuperview];
    [self removeBLackBGView];
}
-(IBAction)noteClickGoodBtnPressed:(id)sender
{
    [self removeNoteClickGoodViewAndBlackBG];
    WebViewVC *vc=[[WebViewVC alloc] init];
    vc.urlStr=[self.shareNoteData objectForKey:@"url"];
    vc.title=@"如何获赞";
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
