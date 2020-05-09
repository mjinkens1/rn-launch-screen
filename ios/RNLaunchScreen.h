//
//  RNLaunchScreen.h
//  LaunchScreen
//
//  Created by Matthew Jinkens on 5/3/20.
//  Copyright © 2020 Facebook. All rights reserved.
//

#import <React/RCTBridgeModule.h>
#import <UIKit/UIKit.h>

@interface RNLaunchScreen : NSObject <RCTBridgeModule>
@property BOOL controllerActive;
+ (void)init:(NSString *)nibID;
+ (void)init:(NSString *)storyBoardID bundle:(NSString *)bundle;
+ (void)show:(BOOL)animated;
+ (void)dismiss:(BOOL)animated;
@end

