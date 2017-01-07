//
//  EditInfoVC.m
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "EditInfoVC.h"
#import "EditInfoCell0.h"
#import "EditInfoAddFeeCell.h"
#import "EditInfoFeeCell.h"
#import "EditInfoTagTitleCell.h"
#import "EditInfoTagsCell.h"
#import "MyPhotosVC.h"
#import "CityListVC.h"
#import "SearchSpaceSiteVC.h"
#import "AddFeeVC.h"
#import "AddTagVC.h"
@interface EditInfoVC ()

@end

@implementation EditInfoVC
@synthesize pickerView,doneBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"编辑个人资料";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(noteSaveData) forControlEvents:UIControlEventTouchUpInside];
//    [self setRightNaviBtnTitle:@"保存"];
//    [self.rightNaviBtn addTarget:self action:@selector(submitData) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryOperate=[NSMutableArray arrayWithObjects:@"全科",@"科目二",@"科目三", nil];
    self.coachData=[NSMutableDictionary dictionary];
    self.m_aryFees=[NSMutableArray array];
    self.m_aryTags=[NSMutableArray array];
    self.m_aryShowed=[NSMutableArray arrayWithObjects:@"0",@"addFee" ,@"tagTitle",@"tags",nil];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-35)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self.btnSubmit setFrame:CGRectMake(0, Screen_Height-35, Screen_Width, 35)];
    [self.view addSubview:self.btnSubmit];
    
//    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
//    [appdelegate startUpdateLocationWithBlock:^{
        [self updateData];
//    }];
}
-(void)noteSaveData
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否保存修改？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"保存", nil];
    alert.tag=99;
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==99)
    {
        if (buttonIndex==0)
        {
            [self popSelfViewContriller];
        }
        else
        {
            [self saveDataForTemp];
        }
    }
}
-(void)saveDataForTemp
{
    [self saveData];
    if ([[self.coachData objectForKey:@"telephone"] length]!=11||![MyFounctions isPureNumandCharacters:[self.coachData objectForKey:@"telephone"]])
    {
        [self showMessage:@"请输入正确手机号"];
        return;
    }
    else if (![MyFounctions isPureNumandCharacters:[self.coachData objectForKey:@"jl"]])
    {
        [self showMessage:@"教龄请输入数字"];
        return;
    }
    
    NSMutableArray *arySelectedTags=[NSMutableArray array];
    for (NSDictionary *dic in self.m_aryTags)
    {
        if ([[dic objectForKey:@"status"] integerValue]==1)
        {
            [arySelectedTags addObject:[NSDictionary dictionaryWithObjects:@[[dic objectForKey:@"tagid"]] forKeys:@[@"tagid"]]];
        }
    }
//    if (arySelectedTags.count<1)
//    {
//        [self showMessage:@"请添加标签"];
//        return;
//    }
    
    NSData *jsonDataTags=[self toJSONData:arySelectedTags];
    NSString *jsonStrTags=[[NSString alloc] initWithData:jsonDataTags
                                                encoding:NSUTF8StringEncoding];
    for (NSMutableDictionary *dic in self.m_aryFees)
    {
        [dic removeObjectsForKeys:@[@"feeid"]];
    }
    NSData *jsonDataFees=[self toJSONData:self.m_aryFees];
    NSString *jsonStrFees=[[NSString alloc] initWithData:jsonDataFees
                                                encoding:NSUTF8StringEncoding];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/putMyInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.coachData objectForKey:@"name"],[self.coachData objectForKey:@"dsid"],[self.coachData objectForKey:@"telephone"],[self.coachData objectForKey:@"jl"],[self.coachData objectForKey:@"teachItem"],[self.coachData objectForKey:@"spaceName"],[self.coachData objectForKey:@"spaceAddr"],[self.coachData objectForKey:@"lat"],[self.coachData objectForKey:@"lng"],jsonStrTags,jsonStrFees] forKeys:@[@"mobile",@"name",@"dsid",@"telephone",@"jl",@"teachItem",@"spaceName",@"spaceAddr",@"lat",@"lng",@"tags",@"fees"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self popSelfViewContriller];
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
-(void)viewWillAppear:(BOOL)animated
{
    [self.m_tableView reloadData];
}
-(void)updateData
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/getMyInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.latitude],[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.longitude]] forKeys:@[@"mobile",@"lat",@"lng"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.coachData=(NSMutableDictionary*)req.m_data;
            [self.m_aryTags removeAllObjects];
            [self.m_aryTags addObjectsFromArray:[req.m_data objectForKey:@"tags"]];
            [self.m_aryFees removeAllObjects];
            [self.m_aryFees addObjectsFromArray:[req.m_data objectForKey:@"fees"]];
            for (NSDictionary *dic in self.m_aryFees)
            {
                [self.m_aryShowed insertObject:@"fee" atIndex:1];
            }
            if ([[self.coachData objectForKey:@"spaceAddr"] isEqualToString:@""])
            {
                if (![appdelegate.m_currentAddress isEqualToString:@""])
                {
                    [self.coachData setObject:appdelegate.m_currentAddress forKey:@"spaceAddr"];
                    [self.coachData setObject:[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.latitude] forKey:@"lat"];
                    [self.coachData setObject:[NSString stringWithFormat:@"%f",appdelegate.m_currentLocation.longitude] forKey:@"lng"];
                }
            }
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
-(void)saveData
{
    [self.coachData setObject:self.m_cell0.textfieldName.text forKey:@"name"];
    [self.coachData setObject:self.m_cell0.textfieldMobile.text forKey:@"telephone"];
    [self.coachData setObject:self.m_cell0.textfieldDriveYear.text forKey:@"jl"];
    [self.coachData setObject:self.m_cell0.textfieldSpaceSite.text forKey:@"spaceName"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryShowed.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        self.m_cell0=[tableView dequeueReusableCellWithIdentifier:@"EditInfoCell0"];
        if (self.m_cell0==nil)
        {
            self.m_cell0=[[[NSBundle mainBundle] loadNibNamed:@"EditInfoCell0" owner:nil options:nil] objectAtIndex:0];
            self.m_cell0.delegate=self;
        }
        [self.m_cell0 updateView];
        return self.m_cell0;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"fee"])
    {
        EditInfoFeeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EditInfoFeeCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"EditInfoFeeCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.feeIndex=indexPath.row-1;
        cell.data=(NSMutableDictionary*)[self.m_aryFees objectAtIndex:indexPath.row-1];
        [cell updateView];
        return cell;
    }
    else if([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"addFee"])
    {
        EditInfoAddFeeCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EditInfoAddFeeCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"EditInfoAddFeeCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tagTitle"])
    {
        EditInfoTagTitleCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EditInfoTagTitleCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"EditInfoTagTitleCell" owner:nil options:nil] objectAtIndex:0];
        }
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tags"])
    {
        EditInfoTagsCell *cell=[tableView dequeueReusableCellWithIdentifier:@"EditInfoTagsCell"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"EditInfoTagsCell" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.m_aryData=[NSMutableArray arrayWithArray:self.m_aryTags];
        [cell.m_aryData addObject:[NSDictionary dictionaryWithObjects:@[@"+自定义",@"2",@""] forKeys:@[@"name",@"status",@"tagid"]]];
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
    if([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"0"])
    {
        height=400;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"fee"])
    {
        height=40;
    }
    else if([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"addFee"])
    {
        height=40;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tagTitle"])
    {
        height=30;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"tags"])
    {
        height=40*((self.m_aryTags.count+1)/4+((self.m_aryTags.count+1)%4>0?1:0))+10;//+1 自定义按键
    }
    return height;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"fee"])
    {
        
    }
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
-(void)showEditFeeVC:(NSInteger)index
{
    AddFeeVC *vc=[[AddFeeVC alloc] init];
    vc.addOrEdit=1;
    vc.delegate=self;
    vc.data=[NSMutableDictionary dictionaryWithDictionary:[self.m_aryFees objectAtIndex:index]];
    vc.feeIndex=index;
    [vc updateView];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)deleteFeeInfo:(NSInteger)index
{
    [self.m_aryFees removeObjectAtIndex:index];
    [self.m_aryShowed removeObjectAtIndex:index+1];
    [self.m_tableView reloadData];
}
#pragma mark --------- uipicker view data source
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.m_aryOperate.count;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str=[self.m_aryOperate objectAtIndex:row];
    return str;
}
//creat operate methord
-(void)creatPickerView
{
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-180, Screen_Width, 180)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=0;
    
    [self.view addSubview:pickerView];
    
    self.doneBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    [doneBtn setFrame: CGRectMake(0, Screen_Height-180-40, Screen_Width, 40)];
    [doneBtn setTitle:@"确定" forState:UIControlStateNormal];
    [doneBtn setBackgroundColor:[UIColor lightGrayColor]];
    [doneBtn addTarget:self action:@selector(selectDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.doneBtn];
    
}
-(void)selectDone
{
    NSInteger index= [self.pickerView selectedRowInComponent:0];
    [self.coachData setObject:[NSString stringWithFormat:@"%d",index+1] forKey:@"teachItem"];
    [self.m_tableView reloadData];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
}
#pragma mark -------- event response ------------
-(IBAction)saveDataBtnPressed:(id)sender
{
    [self submitData];
}
-(void)submitData
{
    [self saveData];
    if ([[self.coachData objectForKey:@"headimgurl"] isEqualToString:@""])
    {
        [self showMessage:@"请上传头像"];
        return;
    }
    else if ([[self.coachData objectForKey:@"name"] isEqualToString:@""])
    {
        [self showMessage:@"请输入姓名"];
        return;
    }
    else if ([[self.coachData objectForKey:@"telephone"] isEqualToString:@""]||[[self.coachData objectForKey:@"telephone"] length]!=11||![MyFounctions isPureNumandCharacters:[self.coachData objectForKey:@"telephone"]])
    {
        [self showMessage:@"请输入正确手机号"];
        return;
    }
    else if ([[self.coachData objectForKey:@"jl"] isEqualToString:@""])
    {
        [self showMessage:@"请输入教龄"];
        return;
    }
    else if (![MyFounctions isPureNumandCharacters:[self.coachData objectForKey:@"jl"]])
    {
        [self showMessage:@"教龄请输入数字"];
        return;
    }
    else if ([[self.coachData objectForKey:@"teachItem"] isKindOfClass:[NSString class]]&&[[self.coachData objectForKey:@"teachItem"] isEqualToString:@""])
    {
        [self showMessage:@"请选择教学科目"];
        return;
    }
    else if ([[self.coachData objectForKey:@"dsname"] isEqualToString:@""])
    {
        [self showMessage:@"请选择驾校"];
        return;
    }
    else if ([[self.coachData objectForKey:@"spaceName"] isEqualToString:@""])
    {
        [self showMessage:@"请输入场地名"];
        return;
    }
    else if ([[self.coachData objectForKey:@"spaceAddr"] isEqualToString:@""])
    {
        [self showMessage:@"请选择场地位置"];
        return;
    }
    else if (self.m_aryFees.count<1)
    {
        [self showMessage:@"请添加学费信息"];
        return;
    }
    
    NSMutableArray *arySelectedTags=[NSMutableArray array];
    for (NSDictionary *dic in self.m_aryTags)
    {
        if ([[dic objectForKey:@"status"] integerValue]==1)
        {
            [arySelectedTags addObject:[NSDictionary dictionaryWithObjects:@[[dic objectForKey:@"tagid"]] forKeys:@[@"tagid"]]];
        }
    }
    if (arySelectedTags.count<1)
    {
        [self showMessage:@"请添加标签"];
        return;
    }
    
    NSData *jsonDataTags=[self toJSONData:arySelectedTags];
    NSString *jsonStrTags=[[NSString alloc] initWithData:jsonDataTags
                                            encoding:NSUTF8StringEncoding];
    for (NSMutableDictionary *dic in self.m_aryFees)
    {
        [dic removeObjectsForKeys:@[@"feeid"]];
    }
    NSData *jsonDataFees=[self toJSONData:self.m_aryFees];
    NSString *jsonStrFees=[[NSString alloc] initWithData:jsonDataFees
                                            encoding:NSUTF8StringEncoding];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/createMyCard.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.coachData objectForKey:@"name"],[self.coachData objectForKey:@"dsid"],[self.coachData objectForKey:@"telephone"],[self.coachData objectForKey:@"jl"],[self.coachData objectForKey:@"teachItem"],[self.coachData objectForKey:@"spaceName"],[self.coachData objectForKey:@"spaceAddr"],[self.coachData objectForKey:@"lat"],[self.coachData objectForKey:@"lng"],jsonStrTags,jsonStrFees] forKeys:@[@"mobile",@"name",@"dsid",@"telephone",@"jl",@"teachItem",@"spaceName",@"spaceAddr",@"lat",@"lng",@"tags",@"fees"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self popSelfViewContriller];
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
// 将字典或者数组转化为JSON串
- (NSData *)toJSONData:(id)theData{
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:theData
                                                       options:0
                                                         error:&error];
    
    if ([jsonData length] > 0 && error == nil){
        return jsonData;
    }else{
        return nil;
    }
}
-(void)showMyPhotoVC
{
    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    MyPhotosVC *vc=[[MyPhotosVC alloc] init];
    vc.editInfoVCDelegate=self;
    vc.userInfo=[NSDictionary dictionaryWithDictionary:appdelegate.m_homeVC.userInfo];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showSelectSchoolVC
{
    CityListVC *vc=[[CityListVC alloc] init];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showSearchSpaceSiteVC
{
    SearchSpaceSiteVC *vc=[[SearchSpaceSiteVC alloc] init];
    vc.cityCode=[self.coachData objectForKey:@"citycode"];
    vc.delegate=self;
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showAddFeeVC
{
    AddFeeVC *vc=[[AddFeeVC alloc] init];
    vc.addOrEdit=0;
    vc.delegate=self;
    vc.data=[NSMutableDictionary dictionary];
    [vc.data setObject:@"1" forKey:@"type"];
    [self.navigationController pushViewController:vc animated:YES];
}
-(void)showAddTagVC
{
    AddTagVC *vc=[[AddTagVC alloc] init];
    vc.delegate=self;
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
