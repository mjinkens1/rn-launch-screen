import React from 'react';
import { createStackNavigator } from '@react-navigation/stack';

// Stacks
import { LaunchStack } from '../LaunchStack';

const Stack = createStackNavigator();

export const RootStack = () => {
  return (
    <Stack.Navigator headerMode="none">
      <LaunchStack />
    </Stack.Navigator>
  );
};
