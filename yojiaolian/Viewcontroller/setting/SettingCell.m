//
//  SettingCell.m
//  yojiaolian
//
//  Created by carcool on 10/30/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:YCC_BorderColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
