//
//  AdvertisementCell.m
//  yojiaolian
//
//  Created by carcool on 12/12/15.
//  Copyright (c) 2015 qinyun. All rights reserved.
//

#import "AdvertisementCell.h"

@implementation AdvertisementCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.scrollIndex=0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)updateView
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [self.imagePlayerView removeFromSuperview];
    self.imagePlayerView=nil;
    [self creatPageScrollview];
    
    self.labelZhaosheng.text=[NSString stringWithFormat:@"%d％",[[self.delegate.homeData objectForKey:@"grate"] integerValue]];
    self.labelTongguolv.text=[NSString stringWithFormat:@"%d％",[[self.delegate.homeData objectForKey:@"prate"] integerValue]];
    self.labeljiaolian.text=[NSString stringWithFormat:@"%d",[[self.delegate.homeData objectForKey:@"ecoachNum"] integerValue]];
    self.labelBaomingNum.text=[NSString stringWithFormat:@"%d名",[[self.delegate.homeData objectForKey:@"applyNum"] integerValue]];
    self.labelQiangdanNum.text=[NSString stringWithFormat:@"%d名",[[self.delegate.homeData objectForKey:@"gcoachNum"] integerValue]];
    
    [self showScrollInfo];
}
-(void)showScrollInfo
{
    if ([self.delegate.m_aryScrollInfo count]>0)
    {
        if (self.scrollIndex>=self.delegate.m_aryScrollInfo.count)
        {
            self.scrollIndex=0;
        }
         self.labelYoubobao.text=[[self.delegate.m_aryScrollInfo objectAtIndex:self.scrollIndex] objectForKey:@"info"];
        self.scrollIndex++;
        [self performSelector:@selector(showScrollInfo) withObject:nil afterDelay:2.5];
    }
}
-(void)creatPageScrollview
{
    self.imagePlayerView=[[ImagePlayerView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width,100)];
    [self addSubview:self.imagePlayerView];
    self.imagePlayerView.tag=0;
    [self.imagePlayerView initWithCount:[self.m_aryData count] delegate:self];
    self.imagePlayerView.scrollInterval = 5.0f;
    self.imagePlayerView.autoScroll=YES;
    
    // adjust pageControl position
    self.imagePlayerView.pageControlPosition = ICPageControlPosition_BottomCenter;
    
    // hide pageControl or not
    if (self.m_aryData.count>1)
    {
        self.imagePlayerView.hidePageControl = NO;
    }
    else
    {
        self.imagePlayerView.hidePageControl = YES;
    }
    
}
#pragma mark ------------- image player delegate
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView loadImageForImageView:(WebImageViewNormal *)imageView index:(NSInteger)index
{
    [imageView setWebImageViewWithURL:[NSURL URLWithString:[[self.m_aryData objectAtIndex:index] objectForKey:@"imgurl"]]];
}
- (void)imagePlayerView:(ImagePlayerView *)imagePlayerView didTapAtIndex:(NSInteger)index
{
    [self.delegate showAdverInfoVC:[[self.m_aryData objectAtIndex:index] objectForKey:@"imgSkipUrl"] adverTitle:[[self.m_aryData objectAtIndex:index] objectForKey:@"title"] shareData:[self.m_aryData objectAtIndex:index]];
}
@end
