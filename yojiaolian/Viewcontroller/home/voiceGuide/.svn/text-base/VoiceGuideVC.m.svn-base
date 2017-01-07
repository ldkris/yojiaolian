//
//  VoiceGuideVC.m
//  yojiaolian
//
//  Created by carcool on 5/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "VoiceGuideVC.h"

@interface VoiceGuideVC ()

@end

@implementation VoiceGuideVC
@synthesize _player;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.bg removeFromSuperview];
    [self.view insertSubview:self.bg atIndex:0];
    self.title=@"科三语音播报";
    [self setLeftNaviBtnImage:[UIImage imageNamed:@"back"]];
    [self.leftNaviBtn addTarget:self action:@selector(popSelfViewContriller) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableView];
    [self.m_tableView setFrame:CGRectMake(0, 64, Screen_Width, Screen_Height-64)];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --------------table view delegate and data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.m_cell=[tableView dequeueReusableCellWithIdentifier:@"VoiceGuideCell"];
    if (self.m_cell==nil)
    {
        self.m_cell=[[[NSBundle mainBundle] loadNibNamed:@"VoiceGuideCell" owner:nil options:nil] objectAtIndex:0];
        self.m_cell.delegate=self;
    }
    return self.m_cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 520;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark ---------- event response ------------
-(void)playSound:(NSString *)file
{
    [_player stop];
    _player=nil;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:file ofType:@"mp3"];
    //    NSURL *url = [NSURL URLWithString:path];//不能这样写，因为是本地路径
    NSURL *url = [NSURL fileURLWithPath:path];//本地路径应该这样写
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    //触发play事件的时候会将mp3文件加载到内存中，然后再播放，所以开始的时候可能按按钮的时候会卡，所以需要prepare
    _player.delegate=self;
    [_player prepareToPlay];
    [_player play];
    
    
    
}
#pragma mark ----------- avaudioplayer delegate ---------
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    [self.m_cell stopPlayingAnimation];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
