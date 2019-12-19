import 'package:blemulator_example/model/signal_level.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  List<int> rssiTestValues;
  List<SignalLevel> expectedSignalLevels;

  tearDown(() {
    rssiTestValues = null;
  });

  void testRssiToSignalLevelParsing() {
    rssiTestValues.asMap().forEach((index, rssi) =>
        expect(signalLevelForRssi(rssi), expectedSignalLevels[index]));
  }

  group('SignalLevel for rssi', () {
    test('= null is .unknown', () {
      // when
      rssiTestValues = [null];

      // then
      expectedSignalLevels = [SignalLevel.unknown];
      testRssiToSignalLevelParsing();
    });

    test('<= -90 is .low', () {
      // when
      rssiTestValues = [-91, -90];

      // then
      expectedSignalLevels = [SignalLevel.low, SignalLevel.low];
      testRssiToSignalLevelParsing();
    });

    test('> -90 and <= -60 is .medium', () {
      // when
      rssiTestValues = [-89, -60];

      // then
      expectedSignalLevels = [
        SignalLevel.medium,
        SignalLevel.medium
      ];
      testRssiToSignalLevelParsing();
    });

    test('> -60 is .high', () {
      // when
      rssiTestValues = [-59, -58];

      // then
      expectedSignalLevels = [SignalLevel.high, SignalLevel.high];
      testRssiToSignalLevelParsing();
    });
  });
}
