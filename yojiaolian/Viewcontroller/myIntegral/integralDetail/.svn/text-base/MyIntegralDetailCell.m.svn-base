//
//  MyIntegralDetailCell.m
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "MyIntegralDetailCell.h"

@implementation MyIntegralDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelTime.text=[self.data objectForKey:@"useDate"];
    self.labelIntegral.text=[self.data objectForKey:@"integral"];
    if ([self.labelIntegral.text integerValue]>=0)
    {
        [self.labelIntegral setTextColor:[UIColor darkGrayColor]];
    }
    else
    {
        [self.labelIntegral setTextColor:[UIColor redColor]];
    }
    
}
@end
