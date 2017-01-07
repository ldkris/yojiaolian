//
//  ExchangeSuccessVC.m
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "ExchangeSuccessVC.h"
#import "MyTicketVC.h"
@interface ExchangeSuccessVC ()

@end

@implementation ExchangeSuccessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"兑换抽奖券";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self.btnMyTicket setColor:YCC_Green];
    [self updateView];
}
-(void)updateView
{
    self.labelContent.text=[NSString stringWithFormat:@"您已成功兑换%@张抽奖券，目前剩余积分%@",[self.data objectForKey:@"sheetNum"],[self.data objectForKey:@"surplusIntegral"]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)ticketBtnPressed:(id)sender
{
    MyTicketVC *vc=[[MyTicketVC alloc] init];
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
