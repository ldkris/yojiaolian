//
//  OrderTemplateCell.m
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTemplateCell.h"
#import "OrderTemplatesVC.h"
#import "OrderTemplateDetailVC.h"
@implementation OrderTemplateCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
    [self.btn setClipsToBounds:YES];
    [self.btn.layer setCornerRadius:3.0];
    [self.btn.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
    [self.btn.layer setBorderWidth:0.5];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelContent.text=[self.data objectForKey:@"desc"];
    self.labelTitle.text=[self.data objectForKey:@"tname"];
    if ([[self.data objectForKey:@"isUsed"] integerValue]==1)
    {
        [self.btn.layer setBorderWidth:0];
        [self.btn setBackgroundColor:YCC_Green];
        [self.btn setTitle:@"正在使用" forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    else
    {
        [self.btn.layer setBorderWidth:0.5];
        [self.layer setBorderColor:[[UIColor darkGrayColor] CGColor]];
        [self.btn setBackgroundColor:[UIColor clearColor]];
        [self.btn setTitle:@"查看详情" forState:UIControlStateNormal];
        [self.btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
}
-(IBAction)btnPressed:(id)sender
{
    OrderTemplateDetailVC *vc=[[OrderTemplateDetailVC alloc] init];
    vc.templateID=[NSString stringWithFormat:@"%d",[[self.data objectForKey:@"templateId"] integerValue]];
    if ([[self.data objectForKey:@"isUsed"] integerValue]==1)
    {
        vc.isUsed=YES;
    }
    else
    {
        vc.isUsed=NO;
    }
    [self.delegate.navigationController pushViewController:vc animated:YES];
}
@end
