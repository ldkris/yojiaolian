//
//  OrderTimeCellDescrip.m
//  yojiaolian
//
//  Created by carcool on 4/28/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "OrderTimeCellDescrip.h"

@implementation OrderTimeCellDescrip

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
