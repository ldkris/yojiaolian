//
//  SubmitSchoolVC.m
//  yojiaolian
//
//  Created by carcool on 4/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "SubmitSchoolVC.h"
#import "SearchSchoolVC.h"
#import "EditInfoVC.h"
#import "CityListVC.h"
@interface SubmitSchoolVC ()

@end

@implementation SubmitSchoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"提交驾校信息";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"保存"];
    [self.rightNaviBtn addTarget:self action:@selector(saveSchool) forControlEvents:UIControlEventTouchUpInside];
    self.textfieldSchool.delegate=self;
    self.textfieldSchool.returnKeyType=UIReturnKeyDone;
    [self.textfieldSchool becomeFirstResponder];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.textfieldSchool.text=self.defaultStr;
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
    return YES;
}
-(void)saveSchool
{
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/putMyDsInfo.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textfieldSchool.text,self.levelCode] forKeys:@[@"mobile",@"dsname",@"levelcode"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [self.delegate.delegate.delegate.coachData setObject:@"其他驾校" forKey:@"dsname"];
            [self.delegate.delegate.delegate.coachData setObject:@"0" forKey:@"dsid"];
            [self.navigationController popViewControllerAnimated:NO];
            [self.delegate.navigationController popViewControllerAnimated:NO];
            [self.delegate.delegate.navigationController popViewControllerAnimated:NO];
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
