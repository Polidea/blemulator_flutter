import 'dart:typed_data';

import 'package:blemulator/blemulator.dart';
import 'package:blemulator_example/simulated_peripherals/advance_sensor_tag.dart';

import '../../Command.dart';
import 'test_simulated_peripheral.dart';

const String _temperatureDataUuid =
    "F000AA01-0451-4000-B000-000000000000";
const String _temperatureConfigUuid =
    "F000AA02-0451-4000-B000-000000000000";
const String _temperaturePeriodUuid =
    "F000AA03-0451-4000-B000-000000000000";
// Simplified simulation of Texas Instruments CC2541 SensorTag
// http://processors.wiki.ti.com/images/a/a8/BLE_SensorTag_GATT_Server.pdf

class SensorTagWithDelayedDisconnect extends SimulatedPeripheral with TestCommandHandler implements CommandHandlerInterface {
  SensorTagWithDelayedDisconnect(
      String id,
      {String name = "SensorTag",
        String localName = "SensorTag"})
      : super(
        name: name,
        id: id,
        advertisementInterval: Duration(milliseconds: 800),
        services: [
          SimulatedService(
          uuid: "F000AA00-0451-4000-B000-000000000000",
          isAdvertised: true,
          characteristics: [
            SimulatedCharacteristic(
              uuid: _temperatureDataUuid,
              //czym to się różni od initValue?
              value: Uint8List.fromList([0, 0, 0, 0]),
              convenienceName: "IR Temperature Data",
              isNotifiable: true,
            ),
            BooleanCharacteristic(
              uuid: _temperatureConfigUuid,
              initialValue: false,
              convenienceName: "IR Temperature Config",
            ),
            SimulatedCharacteristic(
                uuid: _temperaturePeriodUuid,
                value: Uint8List.fromList([50]),
                convenienceName: "IR Temperature Period"),
          ])
        ]
  ) {
    scanInfo.localName = localName;
  }

  @override
  void handleDeviceCommand(DeviceCommand deviceCommand) {
    switch (deviceCommand.commandType) {
      case CommandType.DISCONNECT:
        Future.delayed(Duration(milliseconds: 5000))
            .then((_) => onDisconnect());
        break;
      default:
        break;
    }
  }

}