import React from 'react';
import PropTyes from 'prop-types';
import { Linking } from 'react-native';

// Components
import { Text, View } from 'react-native';

// Hooks
import { useLaunchVideo } from 'react-native-launch-screen';
import { useSafeArea } from 'react-native-safe-area-context';
import { useStyles } from 'hooks';

// Styles
import themedStyles from './styles';
export const LaunchAnimationScreen = () => {
  const styles = useStyles(themedStyles);
  const { play, stop } = useLaunchVideo();
  const insets = useSafeArea();

  const onClickYoutubeLink = () => {
    Linking.openURL('https://www.youtube.com/user/amadrien21');
  };

  React.useEffect(() => {
    play(stop);
  }, [play]);

  return (
    <View style={styles.container}>
      <View style={styles.lower} />
      <View style={insets}>
        <View>
          <Text style={styles.heading}>
            Welcome to React Native Launch Screen
          </Text>
          <Text style={styles.message}>
            Thanks for checking out the project! We'd love to hear your
            feedback, suggestions, or ideas. Please feel free to open an issue
            and let us know what you think!
          </Text>
        </View>
      </View>
      <Text style={styles.videoCredit}>
        {`Thanks to `}
        <Text onPress={onClickYoutubeLink} style={styles.videoLink}>
          Night Lights Films
        </Text>
        {` for the awesome launch video!`}
      </Text>
    </View>
  );
};
