//
//  OrderTimeCellSet.m
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTimeCellSet.h"
#import "OrderTimeVC.h"
@implementation OrderTimeCellSet

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=YCC_GrayBG;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
#pragma mark -------- event response -----------
-(IBAction)selectOrderDays:(id)sender
{
    [self.delegate creatPickerView:0];
}
@end
