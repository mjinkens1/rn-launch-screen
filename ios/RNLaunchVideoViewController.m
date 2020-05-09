//
//  RNLaunchVideo.m
//  LaunchScreen
//
//  Created by Matthew Jinkens on 5/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//
#import "RNLaunchVideo.h"

@implementation RNLaunchVideoViewController : AVPlayerViewController

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (object == self.player && [keyPath isEqualToString:@"status"]) {
        if (self.player.status == AVPlayerStatusReadyToPlay || self.player.status == AVPlayerStatusFailed) {
            self.playerInitialized = true;
        }
    }
}

- (void)itemDidFinishPlaying:(NSNotification *) notification {
    if (self.loop) {
        [self.player seekToTime:kCMTimeZero];
        [self.player play];
        return;
    }
    RNLaunchVideo *eventEmitter = [RNLaunchVideo allocWithZone: nil];
    [eventEmitter sendEventWithName:@"PlaybackComplete" body:@{@"status":@"COMPLETE"}];
}

- (void)awaitPlayerReadyOrError {
    NSDate *delayInterval = [NSDate dateWithTimeIntervalSinceNow:0.1];
    [[NSRunLoop mainRunLoop] runUntilDate:delayInterval];
    
    if (!self.playerInitialized) {
        [self awaitPlayerReadyOrError];
    }
}

- (id)init:(NSString *)videoPath fileType:(NSString *)fileType fullScreen:(BOOL)fullScreen loop:(BOOL)loop showsPlaybackControls:(BOOL)showsPlaybackControls overlayView:(UIView *)overlayView {
    self=[super init];
    self.rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    self.overlayView = overlayView;
    self.fullScreen = fullScreen;
    self.loop = loop;
    self.overlayView.frame = self.view.bounds;
    [self initPlayer:videoPath fileType:fileType];
    return self;
}

- (void)initPlayer:(NSString *)videoPath fileType:(NSString *)fileType {
    NSString *filepath = [[NSBundle mainBundle] pathForResource:videoPath ofType:fileType inDirectory:nil];
    NSURL *fileURL = [NSURL fileURLWithPath:filepath];
    self.player = [AVPlayer playerWithURL:fileURL];
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    self.player.muted = true;
    self.player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    self.videoLayer = [AVPlayerLayer playerLayerWithPlayer:self.player];
    self.videoLayer.frame = self.view.bounds;
    
    if (self.fullScreen) {
        self.videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    
    self.modalPresentationStyle = UIModalPresentationCurrentContext;
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.view.layer.opacity = 0.0;
    [self.rootViewController presentViewController:self animated:false completion:^{
        [self.view.layer addSublayer:self.videoLayer];
        [self.view addSubview:self.overlayView];
    }];
    
    [self.player addObserver:self forKeyPath:@"status" options:0 context:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(itemDidFinishPlaying:) name:AVPlayerItemDidPlayToEndTimeNotification object:[self.player currentItem]];
    [self awaitPlayerReadyOrError];
}

@end


