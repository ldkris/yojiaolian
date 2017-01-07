//
//  EditInfoFeeCell.m
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "EditInfoFeeCell.h"
#import "EditInfoVC.h"
@implementation EditInfoFeeCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView setBackgroundColor:YCC_GrayBG];
    
    UILongPressGestureRecognizer * longPressGr = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressToDo:)];
    longPressGr.minimumPressDuration = 1.0;
    [self.btn addGestureRecognizer:longPressGr];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelName.text=[self.data objectForKey:@"name"];
    self.labelPriceAndType.text=[NSString stringWithFormat:@"¥%@/%@",[self.data objectForKey:@"price"],[[self.data objectForKey:@"type"] integerValue]==1?@"全款":@"计时"];
}
-(IBAction)showEditFeeVC:(id)sender
{
    [self.delegate showEditFeeVC:self.feeIndex];
}
-(void)longPressToDo:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        //add your code here
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"是否删除该学费信息？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"删除", nil];
        alert.tag=11;
        [alert show];
    }
}
#pragma mark ---------- alert view delegate --------------
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag==11)
    {
        if (buttonIndex==1)
        {
            [self.delegate deleteFeeInfo:self.feeIndex];
        }
    }
}
@end
