//
//  OrderTemplateDetailCellTime.m
//  yojiaolian
//
//  Created by carcool on 4/29/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTemplateDetailCellTime.h"
#import "OrderTemplateDetailVC.h"
@implementation OrderTemplateDetailCellTime

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
#pragma mark --------- event response ----------
-(IBAction)deleteBtnPressed:(id)sender
{
    if (self.delegate.m_aryData.count>1)
    {
        [self.delegate.m_aryData removeObjectAtIndex:self.timeIndex];
        [self.delegate.m_aryShowed removeObjectAtIndex:self.timeIndex+2];
        [self.delegate.m_tableView reloadData];
    }
    else
    {
        [self.delegate showMessage:@"至少设置一个预约时间段"];
    }
}
@end
