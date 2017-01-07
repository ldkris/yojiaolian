//
//  WriteLogVC.m
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "WriteLogVC.h"
#import "WriteLogCell.h"
@interface WriteLogVC ()

@end

@implementation WriteLogVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"写日志";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self.btn setFrame:CGRectMake(0,Screen_Height-50 , Screen_Width, 50)];
    [self.btn setBackgroundColor:YCC_Green];
    [self.view addSubview:self.btn];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64-50)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self updateData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"写日志"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"写日志"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"template/getTemplateInfoList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],@"1"] forKeys:@[@"mobile",@"functioncode"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            self.m_aryData=[req.m_data objectForKey:@"templates"];
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

#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.m_cell=[tableView dequeueReusableCellWithIdentifier:@"WriteLogCell"];
    if (self.m_cell==nil)
    {
        self.m_cell=[[[NSBundle mainBundle] loadNibNamed:@"WriteLogCell" owner:nil options:nil] objectAtIndex:0];
    }
    self.m_cell.m_aryData=self.m_aryData;
    [self.m_cell updateView];
    return self.m_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 165+self.m_aryData.count*26;
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
#pragma mark ---------- event response ------------
-(IBAction)submitBtnPressed:(id)sender
{
    NSMutableString *strReason=[NSMutableString stringWithString:@""];
    [strReason appendString:self.m_cell.textViewContent.text];
    NSInteger i=0;
    for (NSString *showed in self.m_cell.m_aryShowed)
    {
        if ([showed isEqualToString:@"1"])
        {
            [strReason appendString:[NSString stringWithFormat:@" %@",[[self.m_cell.m_aryData objectAtIndex:i] objectForKey:@"content"]]];
        }
        i++;
    }
    if ([strReason isEqualToString:@""])
    {
        [self showMessage:@"请选择或输入拒绝原因"];
        return;
    }
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"teachinglog/putStudentTeachingLog.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.preData objectForKey:@"practiceId"],strReason] forKeys:@[@"mobile",@"practiceId",@"log_desc"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.delegate reloadAllData];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
