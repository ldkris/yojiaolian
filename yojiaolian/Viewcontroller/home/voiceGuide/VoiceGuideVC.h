//
//  VoiceGuideVC.h
//  yojiaolian
//
//  Created by carcool on 5/13/16.
//  Copyright (c) 2016 qinyun. All rights reserved.
//

#import "YCCViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "VoiceGuideCell.h"
@interface VoiceGuideVC : YCCViewController<AVAudioPlayerDelegate>
{
    
}
@property(nonatomic,retain)AVAudioPlayer *_player;
@property(nonatomic,retain)VoiceGuideCell *m_cell;
-(void)playSound:(NSString*)file;
@end
