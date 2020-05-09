import { Text } from 'react-native';
import { DarkTheme, DefaultTheme } from '@react-navigation/native';

const colors = {
  primary: 'rgb(30, 54, 82)',
  secondary: 'rgb(87, 189, 88)',
  text: 'rgb(255, 255, 255)',
};

const fontSizes = {
  medium: 16,
  large: 22,
};

export const darkTheme = {
  ...DarkTheme,
  colors: {
    ...DarkTheme.colors,
    ...colors,
  },
  fontSizes,
};

export const lightTheme = {
  ...DefaultTheme,
  colors: {
    ...DefaultTheme.colors,
    ...colors,
  },
  fontSizes,
};
