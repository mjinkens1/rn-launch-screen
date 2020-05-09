import { renderHook } from '@testing-library/react-hooks';
import { useStyles } from 'hooks';

const styles = {
  prop1: 'prop1',
  prop2: 'prop2',
};

// Expected output: { prop1: 'makeStyles-prop1-1', prop2: 'makeStyles-prop2-2' }

describe('useStyles', () => {
  test('should return a material-ui styles object', () => {
    const { result } = renderHook(() => useStyles(styles));
    expect(result.current).toEqual({
      prop1: 'makeStyles-prop1-1',
      prop2: 'makeStyles-prop2-2',
    });
  });
});
