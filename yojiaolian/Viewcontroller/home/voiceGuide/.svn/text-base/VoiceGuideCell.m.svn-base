//
//  VoiceGuideCell.m
//  yojiaolian
//
//  Created by carcool on 5/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "VoiceGuideCell.h"
#import "VoiceGuideVC.h"
@implementation VoiceGuideCell

- (void)awakeFromNib {
    // Initialization code
    self.selectionStyle=UITableViewCellSelectionStyleNone;
    self.backgroundColor=[UIColor whiteColor];
    self.playingIndex=-1;
    //==Json数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"voice" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:path options:NSDataReadingMappedIfSafe error:nil];
    NSDictionary *dic= [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    self.m_aryVoice=[NSMutableArray arrayWithArray:[dic objectForKey:@"voiceList"]];
    [self.m_aryVoice addObjectsFromArray:[dic objectForKey:@"actionList"]];
//    NSLog(@"self.m_aryVoice :%@",self.m_aryVoice);
    
    //playing animation
    //定义数组，存放所有图片对象
    NSArray *images=[NSArray arrayWithObjects:[UIImage imageNamed:@"播放中1"],[UIImage imageNamed:@"播放中2"],[UIImage imageNamed:@"播放中3"],nil];
    //定义结构体，方块大小
    CGRect frame=CGRectMake(140, 200, 40, 40);
    //初始化图像视图对象，大小是frame
    self.imgPlaying = [[UIImageView alloc] initWithFrame:frame];
    //imageView的动画图片是数组images
    self.imgPlaying.animationImages = images;
    //按照原始比例缩放图片，保持纵横比
    self.imgPlaying.contentMode = UIViewContentModeScaleAspectFit;
    //切换动作的时间3秒，来控制图像显示的速度有多快，
    self.imgPlaying.animationDuration = 2;
    //动画的重复次数，想让它无限循环就赋成0
    self.imgPlaying.animationRepeatCount = 0;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(IBAction)voiceBtnPressed:(id)sender
{
    UIButton *btn=(UIButton*)sender;
    NSInteger index=btn.tag;
    if (self.delegate._player.isPlaying==YES&&index==self.playingIndex)//playing
    {
        [self.delegate._player stop];
        [self stopPlayingAnimation];
    }
    else
    {
        NSString *voiceFileName=[[self.m_aryVoice objectAtIndex:index] objectForKey:@"file"];
        [self.delegate playSound:voiceFileName];
        
        [self.imgPlaying stopAnimating];
        [self.imgPlaying removeFromSuperview];
        //开始动画
        [self.imgPlaying startAnimating];
        //添加控件
        [self.imgPlaying setFrame:CGRectMake(PARENT_X(btn)+15, PARENT_Y(btn)+3, 40, 40)];
        [self addSubview:self.imgPlaying];
        
        self.playingIndex=index;
    }
}
-(void)stopPlayingAnimation
{
    [self.imgPlaying stopAnimating];
    [self.imgPlaying removeFromSuperview];
}
@end
