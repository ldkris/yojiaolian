//
//  SearchSchoolVC.m
//  yojiaolian
//
//  Created by carcool on 4/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "SearchSchoolVC.h"
#import "SearchSchoolCell.h"
#import "EditInfoVC.h"
#import "CityListVC.h"
#import "SubmitSchoolVC.h"
@interface SearchSchoolVC ()

@end

@implementation SearchSchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"驾校";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.textfieldSchool.delegate=self;
    self.textfieldSchool.returnKeyType=UIReturnKeySearch;
    
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 70+45, Screen_Width, Screen_Height-70-45-35)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self.btnSubmit setFrame: CGRectMake(0, Screen_Height-35, Screen_Width, 35)];
    [self.view addSubview:self.btnSubmit];
    self.btnSubmit.hidden=YES;
}
-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"search/searchDsList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textfieldSchool.text,self.levelCode] forKeys:@[@"mobile",@"dsname",@"levelcode"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"dss"]];
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
#pragma mark -------- textfield delegate -----------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if ([self.textfieldSchool.text isEqualToString:@""])
    {
        [self showMessage:@"请输入驾校名称"];
    }
    else
    {
        [self updateData];
        self.btnSubmit.hidden=NO;
    }
    return YES;
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchSchoolCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SearchSchoolCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SearchSchoolCell" owner:nil options:nil] objectAtIndex:0];
    }
    cell.labelSchool.text=[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"dsname"];
    return cell;
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
    [self.delegate.delegate.coachData setObject:[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"dsname"] forKey:@"dsname"];
    [self.delegate.delegate.coachData setObject:[[self.m_aryData objectAtIndex:indexPath.row] objectForKey:@"dsid"] forKey:@"dsid"];
    [self.navigationController popViewControllerAnimated:NO];
    [self.delegate.navigationController popViewControllerAnimated:NO];
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ------- event response -----------
-(IBAction)subBtnPressed:(id)sender
{
    SubmitSchoolVC *vc=[[SubmitSchoolVC alloc] init];
    vc.delegate=self;
    vc.levelCode=self.levelCode;
    vc.defaultStr=self.textfieldSchool.text;
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
