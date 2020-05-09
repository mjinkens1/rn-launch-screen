# react-native-launch-screen

Customizable launch screen for React Native with support for launch videos

![Launch Video](https://github.com/mjinkens1/rn-launch-screen/RNLaunchScreen.gif)

## Getting started

`$ yarn add rn-launch-screen --save`  
`$ npm install rn-launch-screen --save`

### Mostly automatic installation

`$ cd ios && pod install`

## Usage

### Launch Screen

#### iOS

```objc
// AppDelegate.m
...
+ #import "RNLaunchScreen.h"
...

@implementation AppDelegate

 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if DEBUG
  InitializeFlipper(application);
#endif

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"example" initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];

+ [RNLaunchScreen init:@"LaunchScreen"]; // LaunchScreen.xib file
+ [RNLaunchScreen show];
  return YES;
}

 - (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
```

```js
import React from 'react';
import { Text, View, StyleSheet } from 'react-native';
import { useLaunchScreen } from 'rn-launch-screen';

export const LaunchScreen = () => {
  const { dismiss } = useLaunchScreen();

  React.useEffect(() => {
    dismiss();
  }, [dismiss]);

  return (
    <View style={styles.container}>
      <Text style>React Native Launch Screen</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
  },
});
```

### Launch Video

#### iOS

```objc
// AppDelegate.m
...
+ #import "RNLaunchScreen.h"
...

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
#if DEBUG
  InitializeFlipper(application);
#endif

  RCTBridge *bridge = [[RCTBridge alloc] initWithDelegate:self launchOptions:launchOptions];
  RCTRootView *rootView = [[RCTRootView alloc] initWithBridge:bridge moduleName:@"example" initialProperties:nil];

  rootView.backgroundColor = [[UIColor alloc] initWithRed:1.0f green:1.0f blue:1.0f alpha:1];

  self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
  UIViewController *rootViewController = [UIViewController new];
  rootViewController.view = rootView;
  self.window.rootViewController = rootViewController;
  [self.window makeKeyAndVisible];

+ [RNLaunchScreen init:@"LaunchScreen"]; // LaunchScreen.xib file
+ [RNLaunchVideo  init:@"LaunchVideo" fileType:@"m4v" // Video file LaunchVideo.m4v
+                 fullScreen:true
+                 loop:false
+                 showsPlaybackControls:false
+                 overlayID:@"LaunchVideoOverlay"];  // LaunchVideoOverlay.xib file
  return YES;
}

- (NSURL *)sourceURLForBridge:(RCTBridge *)bridge
{
#if DEBUG
  return [[RCTBundleURLProvider sharedSettings] jsBundleURLForBundleRoot:@"index" fallbackResource:nil];
#else
  return [[NSBundle mainBundle] URLForResource:@"main" withExtension:@"jsbundle"];
#endif
}

@end
```

```js
import React from 'react';
import { Text, View, StyleSheet } from 'react-native';
import { useLaunchVideo } from 'rn-launch-screen';

export const LaunchVideoScreen = () => {
  const { play, stop } = useLaunchVideo();

  React.useEffect(() => {
    // Dismiss the video when finished playing
    play(stop);
  }, [play, stop]);

  return (
    <View style={styles.container}>
      <Text style>React Native Launch Screen</Text>
    </View>
  );
};

const styles = StyleSheet.create({
  container: {
    justifyContent: 'center',
    alignItems: 'center',
  },
});
```
