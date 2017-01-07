//
//  EditInfoAddFeeCell.m
//  yojiaolian
//
//  Created by carcool on 4/11/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "EditInfoAddFeeCell.h"
#import "EditInfoVC.h"
@implementation EditInfoAddFeeCell

- (void)awakeFromNib {
    // Initialization code
    self.backgroundColor=[UIColor clearColor];
    self.selectionStyle=UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)addBtnPressed:(id)sender
{
    [self.delegate showAddFeeVC];
}
@end
