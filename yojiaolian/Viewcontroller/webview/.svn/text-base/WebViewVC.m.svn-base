//
//  WebViewVC.m
//  chena
//
//  Created by carcool on 9/1/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "WebViewVC.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
@interface WebViewVC ()

@end

@implementation WebViewVC
@synthesize webView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    if (![[self.shareData objectForKey:@"shref"] isEqualToString:@""])
    {
        [self setRightNaviBtnImage:[UIImage imageNamed:@"share_post"]];
        [self.rightNaviBtn addTarget:self action:@selector(topRightBtnPressed) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.webView=[[UIWebView alloc] initWithFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    [self.view addSubview:self.webView];
    //    webView.scrollView.bounces=NO;
    //    webView.scalesPageToFit =YES;
    webView.delegate =self;
    
    NSURL* url = [NSURL URLWithString:self.urlStr];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
    [self showLoadingWithBG];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [MobClick endLogPageView:self.title];
}
-(void)viewWillAppear:(BOOL)animated
{
    [MobClick beginLogPageView:self.title];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -------- webview delegate ---------
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self stopLoadingWithBG];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self stopLoadingWithBG];
}
#pragma mark --------- event response -----------
-(void)topRightBtnPressed
{
    //1、创建分享参数
    NSArray* imageArray = @[[self.shareData objectForKey:@"sphoto"]];
    //        （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray)
    {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        
        [shareParams SSDKSetupShareParamsByText:[self.shareData objectForKey:@"sdesc"]
                                         images:imageArray
                                            url:[NSURL URLWithString:[self.shareData objectForKey:@"shref"]]
                                          title:[self.shareData objectForKey:@"stitle"]
                                           type:SSDKContentTypeAuto];
        
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
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
