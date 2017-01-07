//
//  OrderTemplateDetailVC.m
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTemplateDetailVC.h"
#import "OrderTimeCellDescrip.h"
#import "OrderTemplateDetailCellSet.h"
#import "OrderTimeCellTimeTitle.h"
#import "OrderTemplateDetailCellTime.h"
@interface OrderTemplateDetailVC ()

@end

@implementation OrderTemplateDetailVC
@synthesize pickerView,doneBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"预约练车时段";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    self.m_aryData=[NSMutableArray array];
    self.m_aryShowed=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-40)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self.btn setFrame:CGRectMake(0, Screen_Height-40, Screen_Width, 40)];
    [self.view addSubview:self.btn];
    
    [self updateData];
}
-(void)viewWillAppear:(BOOL)animated
{
    if (self.isUsed==NO)
    {
        [self.btn setTitle:@"使用此模板" forState:UIControlStateNormal];
    }
    else
    {
        [self.btn setTitle:@"取消使用" forState:UIControlStateNormal];
    }
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getAppointTemplateInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.templateID] forKeys:@[@"mobile",@"templateId"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            self.data=[NSMutableDictionary dictionaryWithDictionary:req.m_data];
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"periodTemplates"]];
            [self.m_aryShowed removeAllObjects];
            self.m_aryShowed=[NSMutableArray arrayWithObjects:@"descrip",@"timeTitle",@"set", nil];
            for (NSDictionary *dic in self.m_aryData)
            {
                [self.m_aryShowed insertObject:@"time" atIndex:2];
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
    
        if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"descrip"])
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
            OrderTemplateDetailCellTime *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTemplateDetailCellTime"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTemplateDetailCellTime" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            NSString *strBegin=[[self.m_aryData objectAtIndex:indexPath.row-2] objectForKey:@"beginTime"];
            NSString *strEnd=[[self.m_aryData objectAtIndex:indexPath.row-2] objectForKey:@"endTime"];
            cell.labelTime.text=[NSString stringWithFormat:@"%@-%@",strBegin,strEnd];
            cell.labelPeople.text=[NSString stringWithFormat:@"可预约%d人",[[[self.m_aryData objectAtIndex:indexPath.row-2] objectForKey:@"maxNum"] integerValue]];
            cell.timeIndex=indexPath.row-2;
            return cell;
        }
        else if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"set"])
        {
            OrderTemplateDetailCellSet *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTemplateDetailCellSet"];
            if (cell==nil)
            {
                cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTemplateDetailCellSet" owner:nil options:nil] objectAtIndex:0];
                cell.delegate=self;
            }
            if ([[self.data objectForKey:@"repeatStrategy"] integerValue]==1)
            {
                cell.labelRepeat.text=@"每天";
            }
            else
            {
                cell.labelRepeat.text=[NSString stringWithFormat:@"%d天",[[self.data objectForKey:@"repeatStrategy"] integerValue]];
            }
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
    if ([[self.m_aryShowed objectAtIndex:indexPath.row] isEqualToString:@"descrip"])
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
#pragma mark ---------- event response -----------
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
    [self.data setObject:[self.m_aryOperate objectAtIndex:index] forKey:@"adays"];
    [self.m_tableView reloadData];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    
    
//    Http *req=[[Http alloc] init];
//    req.socialMethord=@"appoint/putCoachAppointConfig.yo";
//    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.m_aryOperate objectAtIndex:index]] forKeys:@[@"mobile",@"adays"]];
//    [self showLoadingWithBG];
//    [req startWithBlock:^{
//        [self stopLoadingWithBG];
//        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
//        {
//            [self.data setObject:[self.m_aryOperate objectAtIndex:index] forKey:@"adays"];
//            [self.m_tableView reloadData];
//        }
//        else
//        {
//            if ([req.m_data valueForKey:@"msg"])
//            {
//                [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
//            }
//            else
//            {
//                [self showNetworkError];
//            }
//            
//        }
//        
//    }];
    
}

-(IBAction)btnPressed:(id)sender
{
    if (self.isUsed==YES)//cancel
    {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"取消后学员无法预约练车，确定取消使用当前预约时段" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.tag=11;
        [alert show];
    }
    else
    {
        NSData *jsonDataTags=[self toJSONData:self.m_aryData];
        NSString *jsonStrTags=[[NSString alloc] initWithData:jsonDataTags
                                                    encoding:NSUTF8StringEncoding];
        Http *req=[[Http alloc] init];
        req.socialMethord=@"appoint/putCoachAppointPeriodCfg.yo";
        [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.templateID,[self.data objectForKey:@"repeatStrategy"],[self.data objectForKey:@"adays"],jsonStrTags] forKeys:@[@"mobile",@"templateId",@"repeatStrategy",@"adays",@"periodTemplates"]];
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
