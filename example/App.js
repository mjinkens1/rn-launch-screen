import React from 'react';

// Components
import { AppearanceProvider } from 'react-native-appearance';
import { NavigationContainer } from '@react-navigation/native';
import { SafeAreaProvider } from 'react-native-safe-area-context';

// Hooks
import { useColorScheme } from 'react-native-appearance';

// Navigation
import { LaunchStack } from 'navigation';

// Styles
import { darkTheme, lightTheme } from 'styles';

export default App = () => {
  const scheme = useColorScheme();

  return (
    <NavigationContainer theme={scheme === 'dark' ? darkTheme : lightTheme}>
      <SafeAreaProvider>
        <LaunchStack />
      </SafeAreaProvider>
    </NavigationContainer>
  );
};
