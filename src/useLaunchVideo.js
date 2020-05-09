import React from 'react';
import { NativeEventEmitter, NativeModules } from 'react-native';

const { RNLaunchVideo } = NativeModules;
const videoEmitter = new NativeEventEmitter(RNLaunchVideo);
const { pause, play, start, stop } = RNLaunchVideo;

export const useLaunchVideo = () => {
  const playWithCompletionListener = React.useCallback((onComplete) => {
    const subscription = videoEmitter.addListener('PlaybackComplete', () =>
      onComplete(),
    );
    play();
    return subscription;
  }, []);

  React.useEffect(() => {
    return playWithCompletionListener.remove;
  }, [playWithCompletionListener]);

  return { pause, play: playWithCompletionListener, stop };
};
