//
//  AddTagVC.m
//  yojiaolian
//
//  Created by carcool on 4/14/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "AddTagVC.h"
#import "EditInfoVC.h"
@interface AddTagVC ()

@end

@implementation AddTagVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"自定义";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    [self setRightNaviBtnTitle:@"保存"];
    [self.rightNaviBtn addTarget:self action:@selector(saveData) forControlEvents:UIControlEventTouchUpInside];
    self.textfieldTag.delegate=self;
    self.textfieldTag.returnKeyType=UIReturnKeyDone;
}
-(void)saveData
{
    if ([self.textfieldTag.text isEqualToString:@""])
    {
        [self showMessage:@"请输入自定义标签"];
        return;
    }
    if ([self.textfieldTag.text length]>4)
    {
        [self showMessage:@"自定义标签需在4个字以内"];
        return;
    }
    Http *req=[[Http alloc] init];
    req.socialMethord=@"my/putMyTag.yo";
    [req setParams:@[[[MyFounctions getUserInfo] objectForKey:@"account"],self.textfieldTag.text] forKeys:@[@"mobile",@"tagName"]];
    [self showLoadingWithBG];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            NSInteger tagsNum=0;
            for (NSDictionary *tagdata in self.delegate.m_aryTags)
            {
                if ([[tagdata objectForKey:@"status"] integerValue]==1)
                {
                    tagsNum++;
                }
            }
            
            NSMutableDictionary *tagData=[NSMutableDictionary dictionaryWithObjects:@[self.textfieldTag.text,tagsNum>=6?@"2":@"1",[req.m_data objectForKey:@"tagid"]] forKeys:@[@"name",@"status",@"tagid"]];
            [self.delegate.m_aryTags addObject:tagData];
            [self.delegate.m_tableView reloadData];
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------ textfield delegate ----------
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
