import 'dart:typed_data';

import 'package:blemulator/blemulator.dart';
import 'package:blemulator_example/simulated_peripherals/advance_sensor_tag.dart';


const String _temperatureDataUuid =
    "F000AA01-0451-4000-B000-000000000000";
const String _temperatureConfigUuid =
    "F000AA02-0451-4000-B000-000000000000";
const String _temperaturePeriodUuid =
    "F000AA03-0451-4000-B000-000000000000";
// Simplified simulation of Texas Instruments CC2541 SensorTag
// http://processors.wiki.ti.com/images/a/a8/BLE_SensorTag_GATT_Server.pdf
class BasicSensorTag extends SimulatedPeripheral {
  BasicSensorTag(
      {String id = "12:12:12:12:12:33",
        String name = "SensorTag",
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
  );
}

SimulatedPeripheral peripheral1 = BasicSensorTag();