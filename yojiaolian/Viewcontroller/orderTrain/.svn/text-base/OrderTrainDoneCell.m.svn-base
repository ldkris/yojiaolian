//
//  OrderTrainDoneCell.m
//  yojiaolian
//
//  Created by carcool on 10/19/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "OrderTrainDoneCell.h"

@implementation OrderTrainDoneCell

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
    self.labelTime.text=[self.data objectForKey:@"periodtime"];
    self.labelDate.text=[self.data objectForKey:@"appointdate"];
    switch ([[self.data objectForKey:@"status"] integerValue])
    {
        case 1:
            self.labelStatus.text=@"同意预约";
            [self.labelStatus setTextColor:YCC_Green];
            break;
        case 2:
            self.labelStatus.text=@"拒绝预约";
            [self.labelStatus setTextColor:[UIColor redColor]];
            break;
        case 4:
            self.labelStatus.text=@"同意取消";
            [self.labelStatus setTextColor:YCC_Green];
            break;
        case 5:
            self.labelStatus.text=@"拒绝取消";
            [self.labelStatus setTextColor:[UIColor redColor]];
            break;
        case 8:
            self.labelStatus.text=@"过期未处理";
            [self.labelStatus setTextColor:[UIColor redColor]];
            break;
            
        default:
            self.labelStatus.text=@"无";
            [self.labelStatus setTextColor:YCC_Green];
            break;
    }
}

@end
