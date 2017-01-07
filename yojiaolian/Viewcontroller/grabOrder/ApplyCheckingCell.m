//
//  ApplyCheckingCell.m
//  yojiaolian
//
//  Created by carcool on 4/27/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "ApplyCheckingCell.h"
#import "MyGrabOrderVC.h"
@implementation ApplyCheckingCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor clearColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)appleRulesBtnPressed:(id)sender
{
    [self.delegate showApplyRulesWebview];
}
@end
