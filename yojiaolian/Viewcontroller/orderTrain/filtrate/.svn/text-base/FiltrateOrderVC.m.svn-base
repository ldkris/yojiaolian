//
//  FiltrateOrderVC.m
//  yojiaolian
//
//  Created by carcool on 10/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "FiltrateOrderVC.h"

@interface FiltrateOrderVC ()

@end

@implementation FiltrateOrderVC
@synthesize datePicker,btnPickDone,pickerView,doneBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.bg setBackgroundColor:[UIColor whiteColor]];
    [self.view insertSubview:self.bg atIndex:0];
//    self.title=@"练车预约查询";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setFrame:CGRectMake(0,Screen_Height-50 , Screen_Width, 50)];
    [self.view addSubview:self.btn];
    
    [self.itemBG1 setBackgroundColor:[UIColor whiteColor]];
    [self.itemBG1.layer setCornerRadius:3.0];
    [self.itemBG1.layer setBorderColor:[YCC_TextColor CGColor]];
    [self.itemBG1.layer setBorderWidth:1.0];
    [self.itemBG2 setBackgroundColor:[UIColor whiteColor]];
    [self.itemBG2.layer setCornerRadius:3.0];
    [self.itemBG2.layer setBorderColor:[YCC_TextColor CGColor]];
    [self.itemBG2.layer setBorderWidth:1.0];
    [self.itemBG3 setBackgroundColor:[UIColor whiteColor]];
    [self.itemBG3.layer setCornerRadius:3.0];
    [self.itemBG3.layer setBorderColor:[YCC_TextColor CGColor]];
    [self.itemBG3.layer setBorderWidth:1.0];
    [self.itemBG4 setBackgroundColor:[UIColor whiteColor]];
    [self.itemBG4.layer setCornerRadius:3.0];
    [self.itemBG4.layer setBorderColor:[YCC_TextColor CGColor]];
    [self.itemBG4.layer setBorderWidth:1.0];
    self.textfieldName.delegate=self;
    self.textfieldName.returnKeyType=UIReturnKeyDone;
    
//    vc.m_aryOperate=[NSMutableArray arrayWithObjects:@"同意预约",@"拒绝预约",@"同意取消",@"拒绝取消", nil];
//    vc.data=[NSMutableDictionary dictionaryWithObjects:@[@"",@"1",@"",@""] forKeys:@[@"name",@"operate",@"starttime",@"endtime"]];
    
    [self updateView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"筛选历史记录"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"筛选历史记录"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidLayoutSubviews
{
    if (self.type==3)
    {
        self.itemBG2.hidden=YES;
        //        [self.itemBG3 removeFromSuperview];
        //        [self.itemBG4 removeFromSuperview];
        [self.itemBG3 setFrame:CGRectMake(10, 136, 300, 45)];
        [self.itemBG4 setFrame:CGRectMake(10, 189, 300, 45)];
        //        [self.view addSubview:self.itemBG3];
        //        [self.view addSubview:self.itemBG4];
    }
}
-(void)updateView
{
    self.textfieldName.text=[self.data objectForKey:@"studentname"];
    self.labelOperate.text=[self.m_aryOperate objectAtIndex:[[self.data objectForKey:@"status"] integerValue]-1];
    self.labelStartTime.text=[[self.data objectForKey:@"starttime"] isEqualToString:@""]?@"起始日期":[self.data objectForKey:@"starttime"];
    self.labelEndTime.text=[[self.data objectForKey:@"endtime"] isEqualToString:@""]?@"结束日期":[self.data objectForKey:@"endtime"];
}
#pragma mark ---------- textfield delegate ------------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self.datePicker removeFromSuperview];
    self.datePicker=nil;
    [self.btnPickDone removeFromSuperview];
    self.btnPickDone=nil;
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.data setObject:self.textfieldName.text forKey:@"studentname"];
    return YES;
}
#pragma mark ----------- event response -----------
-(IBAction)btnPressed:(id)sender
{
    [self.datePicker removeFromSuperview];
    self.datePicker=nil;
    [self.btnPickDone removeFromSuperview];
    self.btnPickDone=nil;
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
    
    [self.data setObject:self.textfieldName.text forKey:@"studentname"];
    UIButton *btn=(UIButton*)sender;
    if (btn.tag==0)
    {
        [self creatPickerView];
    }
    else if (btn.tag==1)
    {
        self.timeType=0;
        [self creatDatePicker];
    }
    else if(btn.tag==2)
    {
        self.timeType=1;
        [self creatDatePicker];
    }
}
-(void)creatDatePicker
{
    self.datePicker=[[UIDatePicker alloc] initWithFrame:CGRectMake(0, Screen_Height-200, Screen_Width, 200)];
    self.datePicker.timeZone=[NSTimeZone timeZoneWithName:@"GMT+0800"];
    [self.datePicker setBackgroundColor:[UIColor whiteColor]];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    NSDate* date = [NSDate date];
    [datePicker setDate:date animated:NO];
    [self.view addSubview:datePicker];
    [datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    
    self.btnPickDone=[UIButton buttonWithType:UIButtonTypeCustom];
    [btnPickDone setFrame:CGRectMake(0, PARENT_Y(datePicker)-35, Screen_Width, 35)];
    [btnPickDone setTitle:@"确定" forState:UIControlStateNormal];
    [btnPickDone setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnPickDone setBackgroundColor:[UIColor darkGrayColor]];
    [btnPickDone addTarget:self action:@selector(pickDone) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.btnPickDone];
}
-(void)dateChanged:(id)sender
{
    //    UIDatePicker * control = (UIDatePicker*)sender;
    //    NSDate* _date = control.date;
    //    NSLog(@"_date :%@",_date);
}
-(void)pickDone
{
    NSDate *date=self.datePicker.date;
    if(self.timeType==0)//start
    {
        [self.data setObject:[[date description] substringToIndex:10] forKey:@"starttime"];
    }
    else if (self.timeType==1)//end
    {
        [self.data setObject:[[date description] substringToIndex:10] forKey:@"endtime"];
    }
    [self updateView];
    [self.datePicker removeFromSuperview];
    self.datePicker=nil;
    [self.btnPickDone removeFromSuperview];
    self.btnPickDone=nil;
    
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
    [self.data setObject:[NSString stringWithFormat:@"%d",index+1] forKey:@"status"];
    [self updateView];
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
}

-(IBAction)startFiltrate:(id)sender
{
    [self.data setObject:self.textfieldName.text forKey:@"studentname"];
    [self.delegate filtrateBtnPressed:self.data];
    [self popSelfViewContriller];
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
