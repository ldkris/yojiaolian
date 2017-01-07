//
//  HomeInfoCell.m
//  yojiaolian
//
//  Created by carcool on 10/5/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "HomeInfoCell.h"

@implementation HomeInfoCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    [self.avatar.layer setCornerRadius:5.0];
    [self.avatar setClipsToBounds:YES];
    [self.lineView0 setBackgroundColor:YCC_GrayBG];
    [self.lineView1 setBackgroundColor:YCC_GrayBG];
    [self.lineView2 setBackgroundColor:YCC_BorderColor];
    [self.lineView3 setBackgroundColor:YCC_BorderColor];
    [self.lineView4 setBackgroundColor:YCC_BorderColor];
    self.m_aryPhoto=[NSMutableArray arrayWithObjects:self.photo1,self.photo2,self.photo3, nil];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [self.avatar setWebImageViewWithURL:[NSURL URLWithString:[self.data objectForKey:@"headimgurl"]]];
    self.labelName.text=[self.data objectForKey:@"name"];
    self.labelSchool.text=[self.data objectForKey:@"dsname"];
    for (WebImageViewNormal *photo in self.m_aryPhoto)
    {
        [photo setImage:nil];
    }
    NSInteger i=0;
    while (i<3&&i<[[self.data objectForKey:@"imgurls"] count])
    {
        WebImageViewNormal *photo=[self.m_aryPhoto objectAtIndex:i];
        [photo setWebImageViewWithURL:[NSURL URLWithString:[[self.data objectForKey:@"imgurls"] objectAtIndex:i]]];
        i++;
    }
    
}
//-(IBAction)avatarBtnPressed:(id)sender
//{
//    [self.delegate showScreenViewForAvatar:self.avatar.image];
//}
@end
