// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

import 'peripherals.dart';

//import 'basic_sensor_tag.dart';

void main() {
  group('Counter App', () {
    // First, define the Finders and use them to locate widgets from the
    // test suite. Note: the Strings provided to the `byValueKey` method must
    // be the same as the Strings we used for the Keys in step 1.
//    final SerializableFinder cellFinder1 = find.byValueKey("asd");
//    final flutterTest.Finder cellFinder2 = flutterTest.find.by(Key("asd"));

    FlutterDriver driver;

    // Connect to the Flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();

    });

    // Close the connection to the driver after the tests have completed.
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('should show all simulated devices', () async {
      await driver.waitFor(find.text("4B:99:4C:34:DE:88"));
      await driver.waitFor(find.text("12:12:12:12:12:33"));
    });

    test('connect to a sensor tag', () async {
      await driver.tap(find.text("4B:99:4C:34:DE:88"));
      await driver.waitFor(find.byValueKey("connectionStateContainer"));
      await driver.tap(find.text("Connect"));
      await driver.waitFor(find.text("Disconnnect"));
      Communicator.disconnect();
      await driver.waitFor(find.text("kabum"));

//      expect(await driver.getText(find.byValueKey("connectionState")), "kabum");
    });

  });
}