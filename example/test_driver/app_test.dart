// Imports the Flutter Driver API.
import 'dart:convert';

import 'package:flutter_driver/flutter_driver.dart';
import 'package:ozzie/ozzie.dart';
import 'package:test/test.dart';
import 'instrumentation/Command.dart';
import 'instrumentation/test_isolate/test_devices.dart';



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
      await driver.waitFor(find.text(sensorTagWithDelayedDisconnectStub.deviceId));
      await driver.waitFor(find.text(sensorStagStub.deviceId));
      await driver.waitFor(find.text(unconnectablePeripheralStub.deviceId));
    });

    test('connect and disconnect', () async {
      await driver.waitFor(find.text(sensorTagWithDelayedDisconnectStub.deviceId));
      await driver.waitFor(find.text(sensorStagStub.deviceId));
      await driver.waitFor(find.text(unconnectablePeripheralStub.deviceId));


      await driver.tap(find.text(sensorStagStub.deviceId));
      await driver.waitFor(find.byValueKey("connectionStateContainer"));
      await driver.tap(find.text("Connect"));
      await driver.waitFor(find.text("PeripheralConnectionState.connected"));

      var command = DeviceCommand(CommandType.DISCONNECT, sensorStagStub.deviceId);

      driver.requestData(jsonEncode(command));
      await driver.waitFor(find.text("PeripheralConnectionState.disconnected"));

    });

    test('connect and delayed disconnect', () async {
      driver.tap(find.byTooltip('Back'));
      await driver.waitFor(find.text(sensorTagWithDelayedDisconnectStub.deviceId));
      await driver.waitFor(find.text(sensorStagStub.deviceId));
      await driver.waitFor(find.text(unconnectablePeripheralStub.deviceId));


      await driver.tap(find.text(sensorTagWithDelayedDisconnectStub.deviceId));
      await driver.waitFor(find.byValueKey("connectionStateContainer"));
      await driver.tap(find.text("Connect"));
      await driver.waitFor(find.text("PeripheralConnectionState.connected"));

      var command = DeviceCommand(CommandType.DISCONNECT, sensorTagWithDelayedDisconnectStub.deviceId);

      driver.requestData(jsonEncode(command));

      await driver.waitFor(find.text("PeripheralConnectionState.disconnected"), timeout: Duration(seconds: 10));

    });

//    test('connection error', () async {
//      driver.tap(find.byTooltip('Back'));
//      await driver.tap(find.text(unconnectablePeripheralStub.deviceId));
//      await driver.waitFor(find.byValueKey("connectionStateContainer"));
//      await driver.tap(find.text("Connect"));
//      await driver.waitFor(find.text("Connection Error"), timeout: Duration(seconds: 3));
//    });

  });
}