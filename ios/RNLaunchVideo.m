//
//  RNLaunchVideo.m
//  LaunchScreen
//
//  Created by Matthew Jinkens on 5/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "RNLaunchScreen.h"
#import "RNLaunchVideo.h"

static UIViewController *rootViewController;
static RNLaunchVideoViewController *viewController;
static RNLaunchScreen *launchScreen;
static UIView *overlayView;
static RNLaunchVideo *sharedInstance;
static dispatch_once_t onceToken;

@implementation RNLaunchVideo

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

+ (id)allocWithZone:(NSZone *)zone {
    dispatch_once(&onceToken, ^{
        sharedInstance = [super allocWithZone:zone];
    });
    return sharedInstance;
}

- (NSArray<NSString *> *)supportedEvents {
  return @[@"PlaybackComplete"];
}

+ (void)init:(NSString *)videoPath fileType:(NSString *)fileType fullScreen:(BOOL)fullScreen loop:(BOOL)loop showsPlaybackControls:(BOOL)showsPlaybackControls overlayID:(NSString *)overlayID {
    [RNLaunchScreen show:false];
    rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
    if (overlayID) {
        overlayView = [[[NSBundle mainBundle] loadNibNamed:overlayID owner:self options:nil] objectAtIndex:0];
    } else {
        overlayView = nil;
    }
    viewController = [[RNLaunchVideoViewController alloc] init:videoPath fileType:fileType fullScreen:fullScreen loop:loop showsPlaybackControls:showsPlaybackControls overlayView:overlayView];
    launchScreen = launchScreen;
    return;
}

RCT_EXPORT_METHOD(play) {
    viewController.view.layer.opacity = 1.0;
    [viewController.player play];
    [RNLaunchScreen dismiss:false];
}

RCT_EXPORT_METHOD(pause) {
    [viewController.player pause];
}

RCT_EXPORT_METHOD(stop) {
    [viewController.player pause];
    [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        viewController.view.alpha = 0;
    } completion:^(BOOL finished){
        [viewController dismissViewControllerAnimated:false completion:nil];
    }];
}

@end
