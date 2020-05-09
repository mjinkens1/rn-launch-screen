import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';

// Screens
import { LaunchAnimationScreen } from 'screens';

const Stack = createStackNavigator();

export const LaunchStack = () => {
  return (
    <Stack.Navigator headerMode="none">
      <Stack.Screen
        name="LaunchAnimationScreen"
        component={LaunchAnimationScreen}
      />
    </Stack.Navigator>
  );
};
