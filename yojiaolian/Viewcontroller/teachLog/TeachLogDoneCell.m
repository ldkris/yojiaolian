//
//  TeachLogDoneCell.m
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "TeachLogDoneCell.h"

@implementation TeachLogDoneCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelName.text=[self.data objectForKey:@"studentname"];
    self.labelDate.text=[self.data objectForKey:@"date"];
    switch ([[self.data objectForKey:@"status"] integerValue])
    {
        case 6:
            self.labelStatus.text=@"已写日志";
            [self.labelStatus setTextColor:YCC_Green];
            break;
//        case 7:
//            self.labelStatus.text=@"未写日志";
//            [self.labelStatus setTextColor:[UIColor redColor]];
//            break;
            
        default:
            self.labelStatus.text=@"已写日志";
            [self.labelStatus setTextColor:YCC_Green];
            break;
    }
}


@end
