// Imports the Flutter Driver API.
import 'dart:convert';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:ozzie/ozzie.dart';
import 'package:test/test.dart';
import 'instrumentation/Command.dart';

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
      await driver.waitFor(find.text("12:12:12:12:12:33"));
    });

    test('connect and disconnect', () async {
      print(">>>>>>>>>>>>>> 0");
      await driver.waitFor(find.text("12:12:12:12:12:11"));
      await driver.waitFor(find.text("12:12:12:12:12:22"));
      await driver.waitFor(find.text("12:12:12:12:12:33"));


      print(">>>>>>>>>>>>>> 1");
      await driver.tap(find.text("12:12:12:12:12:22"));
      print(">>>>>>>>>>>>>> 2");
      await driver.waitFor(find.byValueKey("connectionStateContainer"));
      print(">>>>>>>>>>>>>> 3");
      await driver.tap(find.text("Connect"));
      print(">>>>>>>>>>>>>> 4");
      await driver.waitFor(find.text("PeripheralConnectionState.connected"));
      print(">>>>>>>>>>>>>> 5");

      var command = DeviceCommand(CommandType.DISCONNECT, "12:12:12:12:12:22");

      driver.requestData(jsonEncode(command));
      print(">>>>>>>>>>>>>> 6");
      await driver.waitFor(find.text("PeripheralConnectionState.disconnected"));
      print(">>>>>>>>>>>>>> 7");

    });

    test('connect and delayed disconnect', () async {
      print("---------0");
      driver.tap(find.byTooltip('Back'));
      await driver.waitFor(find.text("12:12:12:12:12:11"));
      await driver.waitFor(find.text("12:12:12:12:12:22"));
      await driver.waitFor(find.text("12:12:12:12:12:33"));


      print("---------1");
      await driver.tap(find.text("12:12:12:12:12:11"));
      print("---------2");
      await driver.waitFor(find.byValueKey("connectionStateContainer"));
      print("---------3");
      await driver.tap(find.text("Connect"));
      print("---------4");
      await driver.waitFor(find.text("PeripheralConnectionState.connected"));
      print("---------5");

      var command = DeviceCommand(CommandType.DISCONNECT, "12:12:12:12:12:11");

      driver.requestData(jsonEncode(command));
      print("---------6");

      await driver.waitFor(find.text("PeripheralConnectionState.disconnected"), timeout: Duration(seconds: 10));
      print("---------7");

    });

    test('connection error', () async {
      driver.tap(find.byTooltip('Back'));
      await driver.tap(find.text("12:12:12:12:12:33"));
      await driver.waitFor(find.byValueKey("connectionStateContainer"));
      await driver.tap(find.text("Connect"));
      await driver.waitFor(find.text("Connection Error"), timeout: Duration(seconds: 3));
    });

  });
}