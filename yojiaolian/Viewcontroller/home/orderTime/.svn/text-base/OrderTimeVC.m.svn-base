//
//  OrderTimeVC.m
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTimeVC.h"
#import "OrderTemplatesVC.h"
#import "OrderTimeCellDescrip.h"
#import "OrderTimeCellTimeTitle.h"
#import "OrderTimeCellTime.h"
#import "OrderTimeCellSet.h"
@interface OrderTimeVC ()

@end

@implementation OrderTimeVC
@synthesize pickerView,doneBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"预约练车时段";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"查看模版"];
    [self.rightNaviBtn addTarget:self action:@selector(showSelectOrderTemplate) forControlEvents:UIControlEventTouchUpInside];
    
    self.isFirstTime=YES;
    self.m_aryData=[NSMutableArray array];
    self.m_aryShowed=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    self.btn.hidden=YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [self updateData];
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getCoachAppointCfgInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=[NSMutableDictionary dictionaryWithDictionary:req.m_data];
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"periodTemplates"]];
            [self.m_aryShowed removeAllObjects];
            
            if (self.m_aryData.count==0)
            {
                self.m_aryShowed=[NSMutableArray arrayWithObjects:@"add", nil];
                self.btn.hidden=YES;
                if (self.isFirstTime==YES)
                {
                    OrderTemplatesVC *vc=[[OrderTemplatesVC alloc] init];
                    [self.navigationController pushViewController:vc animated:YES];
                }
            }
            else
            {
                self.m_aryShowed=[NSMutableArray arrayWithObjects:@"descrip",@"timeTitle",@"set", nil];
                for (NSDictionary *dic in self.m_aryData)
                {
                    [self.m_aryShowed insertObject:@"time" atIndex:2];
                }
                self.btn.hidden=NO;
            }
            [self.m_tableView reloadData];
            self.isFirstTime=NO;
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
-(void)showSelectOrderTemplate
{
    OrderTemplatesVC *vc=[[OrderTemplatesVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"add"])//选择模版
    {
        UITableViewCell *cell=[[UITableViewCell alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 120)];
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell.backgroundColor=YCC_GrayBG;
        UILabel *labelNote=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, Screen_Width, 30)];
        labelNote.text=@"请选择预约模版";
        labelNote.textAlignment=NSTextAlignmentCenter;
        [labelNote setTextColor:[UIColor lightGrayColor]];
        [labelNote setFont:[UIFont systemFontOfSize:15.0]];
        [cell addSubview:labelNote];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"descrip"])
    {
        OrderTimeCellDescrip *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTimeCellDescrip"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTimeCellDescrip" owner:nil options:nil] objectAtIndex:0];
        }
        cell.labelDescrip.text=[self.data objectForKey:@"desc"];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"timeTitle"])
    {
        OrderTimeCellTimeTitle *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTimeCellTimeTitle"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTimeCellTimeTitle" owner:nil options:nil] objectAtIndex:0];
        }
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"time"])
    {
        OrderTimeCellTime *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTimeCellTime"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTimeCellTime" owner:nil options:nil] objectAtIndex:0];
        }
        NSString *strBegin=[[self.m_aryData objectAtIndex:indexPath.row-2] objectForKey:@"beginTime"];
        NSString *strEnd=[[self.m_aryData objectAtIndex:indexPath.row-2] objectForKey:@"endTime"];
        cell.labelTime.text=[NSString stringWithFormat:@"%@-%@",strBegin,strEnd];
        cell.labelPeople.text=[NSString stringWithFormat:@"可预约%d人",[[[self.m_aryData objectAtIndex:indexPath.row-2] objectForKey:@"maxNum"] integerValue]];
        return cell;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"set"])
    {
        OrderTimeCellSet *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTimeCellSet"];
        if (cell==nil)
        {
            cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTimeCellSet" owner:nil options:nil] objectAtIndex:0];
            cell.delegate=self;
        }
        cell.labelRepeat.text=[NSString stringWithFormat:@"%d天",[[self.data objectForKey:@"repeatStrategy"] integerValue]];
        cell.labelDay.text=[NSString stringWithFormat:@"%d天",[[self.data objectForKey:@"adays"] integerValue]];
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
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"add"])
    {
        height=120;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"descrip"])
    {
        height=60;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"timeTitle"])
    {
        height=30;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"time"])
    {
        height=40;
    }
    else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"set"])
    {
        height=110;
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
#pragma mark ----------- event response ---------
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
-(void)creatPickerView:(NSInteger)tagIndex//0:fee type 1:license type
{
    self.m_aryOperate=[NSMutableArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",nil];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    self.pickerView = [[ UIPickerView alloc] initWithFrame:CGRectMake(0, Screen_Height-180, Screen_Width, 180)];
    [self.pickerView setBackgroundColor:[UIColor whiteColor]];
    pickerView.delegate = self;
    pickerView.dataSource =  self;
    pickerView.showsSelectionIndicator = YES;
    pickerView.tag=tagIndex;
    
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
    
    [self.pickerView removeFromSuperview];
    [self.doneBtn removeFromSuperview];
    
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/putCoachAppointConfig.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.m_aryOperate objectAtIndex:index]] forKeys:@[@"mobile",@"adays"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.data setObject:[self.m_aryOperate objectAtIndex:index] forKey:@"adays"];
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
-(IBAction)cancelTemplate:(id)sender
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"取消后学员无法预约练车，确定取消使用当前预约时段" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag=11;
    [alert show];
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        if (buttonIndex==1)
        {
            Http *req=[[Http alloc] init];
            req.socialMethord=@"appoint/cancelAppointTemplate.yo";
            [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"]] forKeys:@[@"mobile"]];
            [self showLoadingWithBG];
            [req startWithBlock:^{
                [self stopLoadingWithBG];
                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
                {
                    [self updateData];
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
