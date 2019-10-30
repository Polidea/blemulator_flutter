// Imports the Flutter Driver API.
import 'package:flutter_driver/flutter_driver.dart';
import 'package:ozzie/ozzie.dart';
import 'package:test/test.dart';

//import 'peripherals.dart';

void main() {
  group('Blesimulator sample app', () {

    FlutterDriver driver;
    Ozzie ozzie;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
      ozzie = Ozzie.initWith(driver, groupName: 'Blemulator');

    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
        ozzie.generateHtmlReport();
      }
    });

    test('should show all simulated devices', () async {
      await driver.waitFor(find.text("12:12:12:12:12:11"));
      await driver.waitFor(find.text("12:12:12:12:12:22"));
    });

    test('connect to a sensor tag', () async {
      await driver.tap(find.text("12:12:12:12:12:11"));
      await driver.waitFor(find.byValueKey("connectionStateContainer"));
      await driver.tap(find.text("Connect"));
      await driver.waitFor(find.text("PeripheralConnectionState.connected"));
    });

  });
}