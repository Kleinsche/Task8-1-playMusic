//
//  ViewController.m
//  播放声音
//
//  Created by 🍋 on 16/9/7.
//  Copyright © 2016年 🍋. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "Lrc.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITextField *lrcTextField;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@property (strong, nonatomic) IBOutlet UIButton *playBtn;
@property (strong,nonatomic) NSTimer *timer;
@property (strong,nonatomic) Lrc * lrc;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"音乐" ofType:@"mp3"]] error:nil];
    
    self.lrc = [[Lrc alloc]init];
    [self.lrc initLrc];
    self.lrcTextField.text = self.lrc.lrcArray[0];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeLrc) userInfo:nil repeats:YES];
}



-(void)changeLrc{
    int t = self.audioPlayer.currentTime;
    for (int i = 0; i < self.lrc.lrcArray.count; i++) {
        if ([self.lrc.timeArray[i] isEqualToString:[NSString stringWithFormat:@"%d", t]]) {
            self.lrcTextField.text = self.lrc.lrcArray[i];
        }
    }
    if (self.audioPlayer.currentTime/self.audioPlayer.duration > 0.99) {
        [self StopMusic:nil];
    }
}


- (IBAction)PlayMusic:(UIButton *)sender {
    if (self.audioPlayer.playing) {
        [self.audioPlayer pause];
        [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    }else{
        [self.audioPlayer play];
        [self.playBtn setTitle:@"暂停" forState:UIControlStateNormal];
    }
}

//- (IBAction)PauseMusic:(UIButton *)sender {
////    [_audioPlayer pause];
//    double currentTime = _audioPlayer.currentTime;
//    NSLog(@"%02d",(int)currentTime%60);
//}

- (IBAction)StopMusic:(UIButton *)sender {
    [self.audioPlayer stop];
    self.audioPlayer.currentTime = 0;
    [self.playBtn setTitle:@"播放" forState:UIControlStateNormal];
    self.lrcTextField.text = self.lrc.lrcArray[0];
}


@end
