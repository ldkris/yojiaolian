//
//  OrderTrainDetailVC.m
//  yojiaolian
//
//  Created by carcool on 10/22/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderTrainDetailVC.h"
#import "OrderTrainDetailCell.h"
@interface OrderTrainDetailVC ()

@end

@implementation OrderTrainDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"预约详情";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
    
    [self updateData];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"预约详情"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"预约详情"];
}
-(void)updateData
{
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"appoint/getStudentAppointInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],[self.preData objectForKey:@"appointid"]] forKeys:@[@"mobile",@"appointid"]];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderTrainDetailCell *cell=[tableView dequeueReusableCellWithIdentifier:@"OrderTrainDetailCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"OrderTrainDetailCell" owner:nil options:nil] objectAtIndex:0];
        cell.delegate=self;
    }
    cell.data=self.data;
    [cell updateView];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self.data objectForKey:@"status"] integerValue]==1)
    {
        return 410-55;
    }
    else
    {
        NSString *reason=[self.data objectForKey:@"reason_desc"];
        float contentHeight=[MyFounctions calculateLabelHeightWithString:reason Width:224 font:[UIFont systemFontOfSize:14]];
        return 396+contentHeight;
    }
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end