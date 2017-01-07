//
//  WelcomeVC.m
//  yocheche
//
//  Created by carcool on 7/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "WelcomeVC.h"
#import "RegisterNewVC.h"
#import "ForgetPasswordVC.h"
#import "MobClick.h"
@interface WelcomeVC ()

@end

@implementation WelcomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doWeixinLogin:) name:@"weixinLogin" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doWeiboLogin:) name:@"weiboLogin" object:nil];
    self.textFieldPhone.delegate=self;
    self.textFieldPassword.delegate=self;
    self.textFieldPassword.secureTextEntry=YES;
    self.textFieldPhone.returnKeyType=UIReturnKeyDone;
    self.textFieldPassword.returnKeyType=UIReturnKeyDone;
    self.isRegister=NO;
//    if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]])
//    {
//        self.labelweixin.hidden=YES;
//        self.imgweixin.hidden=YES;
//        self.btnweixin.hidden=YES;
//    }
//    if (![WeiboSDK isWeiboAppInstalled])
//    {
//        self.labelweibo.hidden=YES;
//        self.imgweibo.hidden=YES;
//        self.btnweibo.hidden=YES;
//    }
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:@"登录页"];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:@"登录页"];
    self.navigationController.navigationBar.hidden=YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark ------- textfield delegate
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark ------- event response
-(IBAction)loginBtnPressed:(id)sender
{
    if ([self.textFieldPhone.text isEqualToString:@""])
    {
        [self showMessage:@"请输入手机号"];
        return;
    }
    else if ([self.textFieldPassword.text isEqualToString:@""])
    {
        [self showMessage:@"请输入密码"];
        return;
    }
    [self.textFieldPhone resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"certification/login.yo";
    [req setParams:@[__BASE64(self.textFieldPhone.text),[MyFounctions md5:self.textFieldPassword.text]] forKeys:@[@"mobile",@"password"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64(self.textFieldPhone.text),[[req.m_data objectForKey:@"coachid"] stringValue]] forKeys:@[@"account",@"coachid"]]];
            [self dismissViewControllerAnimated:YES completion:^{
                [MobClick profileSignInWithPUID:__BASE64(self.textFieldPhone.text)];
            }];
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
#pragma mark ------- event response
-(void)doLogin:(NSString*)mobile password:(NSString*)password
{
    [self.textFieldPhone resignFirstResponder];
    [self.textFieldPassword resignFirstResponder];
    [self showLoadingWithBG];
    Http *req=[[Http alloc] init];
    req.socialMethord=@"certification/login.yo";
    [req setParams:@[__BASE64(mobile),[MyFounctions md5:password]] forKeys:@[@"mobile",@"password"]];
    [req startWithBlock:^{
        [self stopLoadingWithBG];
        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
        {
            [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64(mobile),[[req.m_data objectForKey:@"coachid"] stringValue]] forKeys:@[@"account",@"coachid"]]];
            [self dismissViewControllerAnimated:YES completion:^{
                [MobClick profileSignInWithPUID:__BASE64(self.textFieldPhone.text)];
                if (self.isRegister==YES)
                {
                    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
                    [appdelegate.tabBarController btn2Pressed];
                }
            }];
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
-(IBAction)forgetPassword:(id)sender
{
    ForgetPasswordVC *vc=[[ForgetPasswordVC alloc] init];
    vc.delegate=self;
    vc.registerOrForget=1;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark ----- event response
-(IBAction)registerBtnPressed:(id)sender
{
    RegisterNewVC *vc=[[RegisterNewVC alloc] init];
    vc.delegate=self;
    vc.registerOrForget=0;
    [self.navigationController pushViewController:vc animated:YES];
}
#pragma  mark -------------- weixin login ------------------
//-(IBAction)WeixinLogin:(id)sender
//{
//    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    appdelegate.handleURLtype=11;
//    [self sendAuthRequest];
//}
//-(void)sendAuthRequest
//{
//    //构造SendAuthReq结构体
//    SendAuthReq* req =[[SendAuthReq alloc] init];
//    req.scope = @"snsapi_userinfo" ;
//    req.state = @"123" ;
//    //第三方向微信终端发送一个SendAuthReq消息结构
//    [WXApi sendReq:req];
//}
//-(void)doWeixinLogin:(NSNotification*)notify
//{
//    
//    [self showLoadingWithBG];
//    Http *req=[[Http alloc] init];
//    req.socialMethord=@"wx/getWxUser.yo";
//    [req setParams:@[[notify.userInfo objectForKey:@"code"]] forKeys:@[@"code"]];
//    [req startWithBlock:^{
//        
//        [self stopLoadingWithBG];
//        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
//        {
//            self.weixindata=[NSMutableDictionary dictionaryWithDictionary:req.m_data];
//            
//            [self showLoadingWithBG];
//            Http *req=[[Http alloc] init];
//            [req setParams:@[@"user.register",__BASE64([self.weixindata objectForKey:@"account"]),[MyFounctions md5:@"111111"],@"2",[self.weixindata objectForKey:@"headurl"],[self.weixindata objectForKey:@"nickname"]] forKeys:@[@"method",@"account",@"password",@"type",@"img",@"nickname"]];
//            [req startWithBlock:^{
//                [self stopLoadingWithBG];
//                if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
//                {
//                    [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64([self.weixindata objectForKey:@"account"])] forKeys:@[@"account"]]];
//                    [self dismissViewControllerAnimated:YES completion:^{
//                        [[NSNotificationCenter defaultCenter] removeObserver:self];
//                    }];
//                }
//                else
//                {
//                    if ([req.m_data valueForKey:@"msg"])
//                    {
//                        [self showAlertViewWithTitle:nil message:[req.m_data valueForKey:@"msg"] cancelButton:@"确定" others:nil];
//                    }
//                    else
//                    {
//                        [self showNetworkError];
//                    }
//                    
//                }
//                
//            }];
//
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
//
//}
//#pragma mark -------- weibo ---------------
//-(IBAction)SinaLogin:(id)sender
//{
//    AppDelegate *appdelegate=(AppDelegate*)[[UIApplication sharedApplication]delegate];
//    appdelegate.handleURLtype=12;
//    
//    WBAuthorizeRequest *request=[WBAuthorizeRequest request];
//    request.redirectURI=@"http://www.yocheche.com";
//    request.scope=@"all";
//    [WeiboSDK sendRequest:request];
//}
//-(void)doWeiboLogin:(NSNotification*)notify
//{
//    WeiboUser *user=[notify.userInfo objectForKey:@"userInfo"];
//    
//    [self showLoadingWithBG];
//    Http *req=[[Http alloc] init];
//    [req setParams:@[@"user.register",__BASE64(user.userID),[MyFounctions md5:@"111111"],@"3",user.avatarLargeUrl,user.name] forKeys:@[@"method",@"account",@"password",@"type",@"img",@"nickname"]];
//    [req startWithBlock:^{
//        [self stopLoadingWithBG];
//        if ([[req.m_data valueForKey:@"statusCode"] integerValue]==1000)
//        {
//            [MyFounctions saveUserInfo:[NSDictionary dictionaryWithObjects:@[__BASE64(user.userID)] forKeys:@[@"account"]]];
//            [self dismissViewControllerAnimated:YES completion:^{
//                
//            }];
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
//
//}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
