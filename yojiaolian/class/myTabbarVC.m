//
//  myTabbarVC.m
//  EStar
//
//  Created by KingRain on 13-12-26.
//  Copyright (c) 2013年 KingRain. All rights reserved.
//

#import "myTabbarVC.h"
#import "MyFounctions.h"
@interface myTabbarVC ()

@end

@implementation myTabbarVC
@synthesize tabbarBG,btn1,btn2,btn3,itemBG;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //hide the original tabbar.
    self.tabBar.hidden=YES;
    [self createCustomTabBar];
}
- (void)createCustomTabBar
{
    self.tabbarBG = [[UIImageView alloc]initWithFrame:CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-49, Screen_Width, 49)];
//    tabbarBG.image = [UIImage imageNamed:@"tabbar_bg"];
    [tabbarBG setBackgroundColor:[UIColor whiteColor]];
    tabbarBG.userInteractionEnabled = YES;
    [tabbarBG.layer setBorderWidth:0.5];
    [tabbarBG.layer setBorderColor:[YCC_BorderColor CGColor]];
    [self.view addSubview:tabbarBG];
    float btnWidth=Screen_Width/3.0;
    
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setAdjustsImageWhenHighlighted:NO];
    btn1.tag = 0;
    btn1.frame = CGRectMake(0.0, 0.0, btnWidth, 49.0);
    [btn1 setImage:[UIImage imageNamed:@"home_tab2"] forState:UIControlStateNormal];
    [btn1 setImageEdgeInsets:UIEdgeInsetsMake((49-40)/2.0, (btnWidth-40)/2.0, (49-40)/2.0, (btnWidth-40)/2.0)];
    [btn1 addTarget:self action:@selector(btn1Pressed) forControlEvents:UIControlEventTouchUpInside];
    [tabbarBG addSubview:btn1];
    
//    self.notifyView2=[[UIView alloc] initWithFrame:CGRectMake(Screen_Width/4.0+50, 5, 8, 8)];
//    [self.notifyView2 setBackgroundColor:[UIColor redColor]];
//    [self.notifyView2.layer setCornerRadius:4.0];
//    [tabbarBG addSubview:self.notifyView2];
    
    btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setAdjustsImageWhenHighlighted:NO];
    btn2.tag = 1;
    btn2.frame = CGRectMake(btnWidth, 0.0, btnWidth, 49.0);
    [btn2 setImage:[UIImage imageNamed:@"zhaosheng_tab1"] forState:UIControlStateNormal];
    [btn2 setImageEdgeInsets:UIEdgeInsetsMake((49-40)/2.0, (btnWidth-40)/2.0, (49-40)/2.0, (btnWidth-40)/2.0)];
    [btn2 addTarget:self action:@selector(btn2Pressed) forControlEvents:UIControlEventTouchUpInside];
    [tabbarBG addSubview:btn2];
    
    btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setAdjustsImageWhenHighlighted:NO];
    btn3.tag = 2;
    btn3.frame = CGRectMake(btnWidth*2, 0.0, btnWidth, 49.0);
    [btn3 setImage:[UIImage imageNamed:@"setting_tab1"] forState:UIControlStateNormal];
    [btn3 setImageEdgeInsets:UIEdgeInsetsMake((49-40)/2.0, (btnWidth-40)/2.0, (49-40)/2.0, (btnWidth-40)/2.0)];
    [btn3 addTarget:self action:@selector(btn3Pressed) forControlEvents:UIControlEventTouchUpInside];
    [tabbarBG addSubview:btn3];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)showTabBar
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    tabbarBG.frame = CGRectMake(0, Screen_Height-49, 320, 49);
    [UIView commitAnimations];
}
- (void)hideTabBar
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0];
    tabbarBG.frame = CGRectMake(0, Screen_Height, 320, 49);
    [UIView commitAnimations];
}
-(void)btn1Pressed
{
    [self setSelectedIndex:0];
    [btn1 setImage:[UIImage imageNamed:@"home_tab2"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"zhaosheng_tab1"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"setting_tab1"] forState:UIControlStateNormal];
    
}
-(void)btn2Pressed
{
    [self setSelectedIndex:1];
    [btn1 setImage:[UIImage imageNamed:@"home_tab1"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"zhaosheng_tab2"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"setting_tab1"] forState:UIControlStateNormal];
}
-(void)btn3Pressed
{
    [self setSelectedIndex:2];
    [btn1 setImage:[UIImage imageNamed:@"home_tab1"] forState:UIControlStateNormal];
    [btn2 setImage:[UIImage imageNamed:@"zhaosheng_tab1"] forState:UIControlStateNormal];
    [btn3 setImage:[UIImage imageNamed:@"setting_tab2"] forState:UIControlStateNormal];
}
@end