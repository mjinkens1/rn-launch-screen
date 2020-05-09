//
//  RNLaunchVideo.h
//  LaunchScreen
//
//  Created by Matthew Jinkens on 5/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVKit/AVKit.h>
#import <React/RCTBridgeModule.h>
#import <React/RCTEventEmitter.h>
#import "RNLaunchScreen.h"


@interface RNLaunchVideo : RCTEventEmitter <RCTBridgeModule>
+ (void)init:(NSString *)videoPath fileType:(NSString *)fileType fullScreen:(BOOL)fullScreen loop:(BOOL)loop showsPlaybackControls:(BOOL)showsPlaybackControls overlayID:(NSString *)overlayID;
+ (id)allocWithZone:(NSZone *)zone;
@end

@interface RNLaunchVideoViewController : AVPlayerViewController
@property (nonatomic, weak) UIViewController *rootViewController;
@property (nonatomic, weak) UIView *overlayView;
@property (nonatomic, weak) AVPlayerLayer *videoLayer;
@property (nonatomic, weak) RNLaunchVideo *emitter;
@property (nonatomic) BOOL fullScreen;
@property (nonatomic) BOOL loop;
@property (nonatomic) BOOL playerInitialized;
- (id)init:(NSString *)videoPath fileType:(NSString *)fileType fullScreen:(BOOL)fullScreen loop:(BOOL)loop showsPlaybackControls:(BOOL)showsPlaybackControls overlayView:(UIView *)overlayView;
@end
