//
//  RNLaunchScreen.m
//  LaunchScreen
//
//  Created by Matthew Jinkens on 5/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import "RNLaunchScreen.h"
#import "RNLaunchVideo.h"

static UIViewController *rootViewController;
static UIViewController *launchViewController;
static UIView *rootView;
static UIView *launchView;
static BOOL useNib;

@implementation RNLaunchScreen

RCT_EXPORT_MODULE()

- (dispatch_queue_t)methodQueue {
    return dispatch_get_main_queue();
}

+ (void)sharedInit {
    rootViewController = [UIApplication sharedApplication].delegate.window.rootViewController;
}

+ (void)init:(NSString *)storyboardID bundle:(NSBundle *)bundle {
    [self sharedInit];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardID bundle:bundle];
    launchViewController = [storyboard instantiateViewControllerWithIdentifier:storyboardID];
    return;
}

+ (void)init:(NSString *)nibID {
    [self sharedInit];
    rootView =  rootViewController.view;
    launchView = [[[NSBundle mainBundle] loadNibNamed:nibID owner:self options:nil] objectAtIndex:0];
    launchView.frame = rootView.frame;
    useNib = true;
}

+ (void)show:(BOOL)animated {
    if (useNib) {
        if (animated) {
            launchView.alpha = 0;
            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                launchView.alpha = 0;
            } completion:^(BOOL finished){
                        [rootView addSubview:launchView];
                [rootView bringSubviewToFront:launchView];
            }];
            return;
        }
        [rootView addSubview:launchView];
        [rootView bringSubviewToFront:launchView];
        return;
    }
    [rootViewController presentViewController:launchViewController animated:animated completion:nil];
}

+ (void)dismiss:(BOOL)animated {
    if (useNib) {
        if (animated) {
            [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                launchView.alpha = 0;
            } completion:^(BOOL finished){
                [launchView removeFromSuperview];
            }];
            return;
        }
        [launchView removeFromSuperview];
        return;
    }
    [launchViewController dismissViewControllerAnimated:animated completion:nil];
}

RCT_EXPORT_METHOD(show:(BOOL)animated callback:(RCTResponseSenderBlock)callback) {
    [RNLaunchScreen show:animated];
    if(callback){
        callback(@[[NSNull null], [NSNull null]]);
    }
}

RCT_EXPORT_METHOD(dismiss:(BOOL)animated callback:(RCTResponseSenderBlock)callback) {
    [RNLaunchScreen dismiss:animated];
    if(callback){
        callback(@[[NSNull null], [NSNull null]]);
    }
}

@end
