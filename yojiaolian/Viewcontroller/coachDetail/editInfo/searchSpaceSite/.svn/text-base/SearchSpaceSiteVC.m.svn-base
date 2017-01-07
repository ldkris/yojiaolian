//
//  SearchSpaceSiteVC.m
//  yojiaolian
//
//  Created by carcool on 4/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "SearchSpaceSiteVC.h"
#import "SearchSpaceSiteCell.h"
#import "EditInfoVC.h"
@interface SearchSpaceSiteVC ()

@end

@implementation SearchSpaceSiteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"场地位置";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    self.textfieldSpace.delegate=self;
    self.textfieldSpace.returnKeyType=UIReturnKeySearch;
    
    self.m_aryData=[NSMutableArray array];
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 70+45, Screen_Width, Screen_Height-70-45)];
    [self.m_tableView setBackgroundColor:YCC_GrayBG];
}

-(void)updateData
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"search/searchBaiduAreaList.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textfieldSpace.text,self.cityCode] forKeys:@[@"mobile",@"query",@"cityCode"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.m_aryData removeAllObjects];
            [self.m_aryData addObjectsFromArray:[req.m_data objectForKey:@"areas"]];
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
    [self updateData];
    return YES;
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_aryData.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchSpaceSiteCell *cell=[tableView dequeueReusableCellWithIdentifier:@"SearchSpaceSiteCell"];
    if (cell==nil)
    {
        cell=[[[NSBundle mainBundle] loadNibNamed:@"SearchSpaceSiteCell" owner:nil options:nil] objectAtIndex:0];
    }
    NSDictionary *addrssData=[self.m_aryData objectAtIndex:indexPath.row];
    cell.labelAddress.text=[NSString stringWithFormat:@"%@%@%@",[addrssData objectForKey:@"province"],[addrssData objectForKey:@"district"],[addrssData objectForKey:@"address"]];
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
    NSDictionary *addrssData=[self.m_aryData objectAtIndex:indexPath.row];
    [self.delegate.coachData setObject:[NSString stringWithFormat:@"%@%@%@",[addrssData objectForKey:@"province"],[addrssData objectForKey:@"district"],[addrssData objectForKey:@"address"]] forKey:@"spaceAddr"];
    [self.delegate.coachData setObject:[addrssData objectForKey:@"lat"] forKey:@"lat"];
    [self.delegate.coachData setObject:[addrssData objectForKey:@"lng"] forKey:@"lng"];
    [self.navigationController popViewControllerAnimated:YES];
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
