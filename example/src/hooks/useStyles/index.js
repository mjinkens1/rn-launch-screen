import { StyleSheet } from 'react-native';

// Hooks
import { useTheme } from '@react-navigation/native';

// Utils
import * as U from 'utils';

export const useStyles = (styles) => {
  const theme = useTheme();

  return U.ifElse(
    U.is(Function),
    U.compose(StyleSheet.create, U.applyTo(theme)),
    StyleSheet.create,
  )(styles);
};
