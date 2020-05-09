import { NativeModules } from 'react-native';

const { RNLaunchScreen } = NativeModules;
const { dismiss, show } = RNLaunchScreen;

const defaultCallback = () => null;

const withDefaults = (func) => (
  animated = false,
  callback = defaultCallback,
) => {
  func(animated, callback);
};

export const useLaunchScreen = () => ({
  dismiss: withDefaults(dismiss),
  show: withDefaults(show),
});
