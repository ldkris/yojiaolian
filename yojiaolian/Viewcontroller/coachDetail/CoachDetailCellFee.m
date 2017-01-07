//
//  CoachDetailCellFee.m
//  yojiaolian
//
//  Created by carcool on 4/15/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "CoachDetailCellFee.h"
@implementation CoachDetailCellFee

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
-(void)updateView
{
    self.labelName.text=[self.data objectForKey:@"name"];
    NSString *type=@"全款";
    if ([[self.data objectForKey:@"type"] integerValue]==1)
    {
        type=@"全款";
    }
    else if ([[self.data objectForKey:@"type"] integerValue]==2)
    {
        type=@"分时";
    }
    self.labelPriceAndType.text=[NSString stringWithFormat:@"¥%@/%@",[self.data objectForKey:@"price"],type];
}
@end
