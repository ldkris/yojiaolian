//
//  AddFeeVC.m
//  yojiaolian
//
//  Created by carcool on 4/14/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "AddFeeVC.h"
#import "EditInfoVC.h"
@interface AddFeeVC ()

@end

@implementation AddFeeVC
@synthesize pickerView,doneBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"学费信息";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"保存"];
    [self.rightNaviBtn addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_GrayBG];
    self.textfieldFeeName.delegate=self;
    self.textfieldFeePrice.delegate=self;
    self.textfieldFeeName.returnKeyType=UIReturnKeyDone;
    self.textfieldFeePrice.returnKeyType=UIReturnKeyDone;
    [self updateView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateView
{
//    self.labelFeeType.text=[[self.data objectForKey:@"type"] integerValue]==1?@"全款":@"计时";
//    self.labelLicenseType.text=[[self.data objectForKey:@"driveType"] integerValue]==1?@"C1":@"C2";
    if ([[self.data objectForKey:@"type"] integerValue]==1)
    {
        self.labelFeeType.text=@"全款";
    }
    else if ([[self.data objectForKey:@"type"] integerValue]==2)
    {
        self.labelFeeType.text=@"计时";
    }
    if ([[self.data objectForKey:@"driveType"] integerValue]==1)
    {
        self.labelLicenseType.text=@"C1";
    }
    else if ([[self.data objectForKey:@"driveType"] integerValue]==2)
    {
        self.labelLicenseType.text=@"C2";
    }
    self.textfieldFeeName.text=[self.data objectForKey:@"name"];
    self.textfieldFeePrice.text=[self.data objectForKey:@"price"];
}
-(void)saveData
{
    if ([self.labelFeeType.text length]>2)
    {
        [self showMessage:@"请选择学费类型"];
        return;
    }
    else if ([self.labelLicenseType.text length]>2)
    {
        [self showMessage:@"请选择驾照类型"];
        return;
    }
    else if ([self.textfieldFeeName.text isEqualToString:@""])
    {
        [self showMessage:@"请输入学费名称"];
        return;
    }
    else if ([self.textfieldFeePrice.text isEqualToString:@""])
    {
        [self showMessage:@"请输入学费价格"];
        return;
    }
    else if (![MyFounctions isPureNumandCharacters:self.textfieldFeePrice.text])
    {
        [self showMessage:@"学费价格请输入整数"];
        return;
    }
    [self.data setObject:self.textfieldFeeName.text forKey:@"name"];
    [self.data setObject:self.textfieldFeePrice.text forKey:@"price"];
//    if (self.addOrEdit==0)//new
//    {
//        [self.data setObject:@"" forKey:@"feeid"];
//    }
    if (self.addOrEdit==0)
    {
        [self.delegate.m_aryFees addObject:self.data];
        [self.delegate.m_aryShowed insertObject:@"fee" atIndex:1];
        [self.delegate.m_tableView reloadData];
    }
    else
    {
        [self.delegate.m_aryFees replaceObjectAtIndex:self.feeIndex withObject:self.data];
        [self.delegate.m_tableView reloadData];
    }
    [self popSelfViewContriller];
}
#pragma mark -------- textfield delegate -----------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
-(void)creatPickerView:(NSInteger)tagIndex//0:fee type 1:license type
{
    if (tagIndex==0)
    {
        self.m_aryOperate=[NSMutableArray arrayWithObjects:@"全款",@"计时",nil];
    }
    else if (tagIndex==1)
    {
        self.m_aryOperate=[NSMutableArray arrayWithObjects:@"C1",@"C2",nil];
    }
    
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
    if (self.pickerView.tag==0) {
        [self.data setObject:[NSString stringWithFormat:@"%d",index+1] forKey:@"type"];
        self.labelFeeType.text=[[self.data objectForKey:@"type"] integerValue]==1?@"全款":@"计时";
    }
    else
    {
        [self.data setObject:[NSString stringWithFormat:@"%d",index+1] forKey:@"driveType"];
         self.labelLicenseType.text=[[self.data objectForKey:@"driveType"] integerValue]==1?@"C1":@"C2";
    }
    
    [self.pickerView removeFromSuperview];
    self.pickerView =nil;
    [self.doneBtn removeFromSuperview];
    self.doneBtn=nil;
}
-(IBAction)showPickerViewBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    [self creatPickerView:btn.tag];
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
