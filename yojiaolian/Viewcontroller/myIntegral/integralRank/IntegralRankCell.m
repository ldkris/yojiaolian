//
//  IntegralRankCell.m
//  yojiaolian
//
//  Created by carcool on 12/10/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "IntegralRankCell.h"

@implementation IntegralRankCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelName.text=[self.data objectForKey:@"coachname"];
    self.labelIntegral.text=[self.data objectForKey:@"totalIntegral"];
    self.labelRank.text=[self.data objectForKey:@"ranking"];
}
@end
