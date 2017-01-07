//
//  StudyTimeCell.m
//  yojiaolian
//
//  Created by carcool on 10/21/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "StudyTimeCell.h"

@implementation StudyTimeCell

- (void)awakeFromNib {
    // Initialization code
    [self.lineView0 setBackgroundColor:YCC_BorderColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    self.labelDate.text=[self.data objectForKey:@"appointtime"];
    self.labelName.text=[self.data objectForKey:@"studentname"];
    self.labelStudyTime.text=[[self.data objectForKey:@"periodnum"] stringValue];
    if ([[self.data objectForKey:@"teachingitem"] integerValue]==2)
    {
        self.labelClass.text=@"科二";
    }
    else if ([[self.data objectForKey:@"teachingitem"] integerValue]==3)
    {
        self.labelClass.text=@"科三";
    }
    
}
@end
