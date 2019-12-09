import 'dart:async';
import 'dart:math';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:blemulator/blemulator.dart';

// Simplified simulation of Texas Instruments CC2541 SensorTag
// http://processors.wiki.ti.com/images/a/a8/BLE_SensorTag_GATT_Server.pdf
class SensorTag extends SimulatedPeripheral {
  SensorTag(
      {String id = "4B:99:4C:34:DE:77",
      String name = "SensorTag",
      String localName = "SensorTag"})
      : super(
            name: name,
            id: id,
            advertisementInterval: Duration(milliseconds: 800),
            services: [
              //IR Temperature service implemented according to docs
              TemperatureService(
                  uuid: "F000AA00-0451-4000-B000-000000000000",
                  isAdvertised: true,
                  convenienceName: "Temperature service"),
              //Simplified accelerometer service
              SimulatedService(
                  uuid: "F000AA10-0451-4000-B000-000000000000",
                  isAdvertised: true,
                  characteristics: [
                    SimulatedCharacteristic(
                        uuid: "F000AA11-0451-4000-B000-000000000000",
                        value: Uint8List.fromList([0, 0]),
                        convenienceName: "Accelerometer Config",
                        isWritableWithResponse: false,
                        isWritableWithoutResponse: false,
                        isNotifiable: true),
                    SimulatedCharacteristic(
                        uuid: "F000AA12-0451-4000-B000-000000000000",
                        value: Uint8List.fromList([2]),
                        convenienceName: "Accelerometer Config"),
                    SimulatedCharacteristic(
                        uuid: "F000AA13-0451-4000-B000-000000000000",
                        value: Uint8List.fromList([30]),
                        convenienceName: "Accelerometer Period"),
                  ],
                  convenienceName: "Accelerometer Service")
            ]) {
    scanInfo.localName = localName;
  }

  @override
  Future<bool> onConnectRequest() async {
    await Future.delayed(Duration(milliseconds: 200));
    return super.onConnectRequest();
  }

  @override
  Future<void> onDiscoveryRequest() async {
    return Future.delayed(
      Duration(milliseconds: 500),
      () => super.onDiscoveryRequest(),
    );
  }
}

//IR Temperature Service of sensor tag
// According to documentation the sensor can be turned on and off by
// writing to IR Temperature Config characteristic, the period of
// notifications is 10 times the value of IR Temperature Period characteristic
// and the value of the temperature can be retrieved from IR Temperature Data
// characteristic through reading or notifications
class TemperatureService extends SimulatedService {
  static const String _temperatureDataUuid =
      "F000AA01-0451-4000-B000-000000000000";
  static const String _temperatureConfigUuid =
      "F000AA02-0451-4000-B000-000000000000";
  static const String _temperaturePeriodUuid =
      "F000AA03-0451-4000-B000-000000000000";

  bool _readingTemperature = false;

  TemperatureService(
      {@required String uuid,
      @required bool isAdvertised,
      String convenienceName})
      : super(
            uuid: uuid,
            isAdvertised: isAdvertised,
            characteristics: [
              SimulatedCharacteristic(
                uuid: _temperatureDataUuid,
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
            ],
            convenienceName: convenienceName) {
    characteristicByUuid(_temperatureConfigUuid).monitor().listen((value) {
      _readingTemperature = value[0] == 1;

      if (_readingTemperature) {
        SimulatedCharacteristic temperatureDataCharacteristic =
            characteristicByUuid(_temperatureDataUuid);

        temperatureDataCharacteristic.write(
          Uint8List.fromList([0, 0, 100, Random().nextInt(255)]),
          sendNotification: false,
        );
      }
    });

    _emitTemperature();
  }

  void _emitTemperature() async {
    while (true) {
      Uint8List delayBytes =
          await characteristicByUuid(_temperaturePeriodUuid).read();
      int delay = delayBytes[0] * 10;
      await Future.delayed(Duration(milliseconds: delay));

      SimulatedCharacteristic temperatureDataCharacteristic =
          characteristicByUuid(_temperatureDataUuid);

      if (temperatureDataCharacteristic.isNotifying) {
        if (_readingTemperature) {
          temperatureDataCharacteristic
              .write(Uint8List.fromList([0, 0, 100, Random().nextInt(255)]));
        } else {
          temperatureDataCharacteristic.write(Uint8List.fromList([0, 0, 0, 0]));
        }
      }
    }
  }
}

class BooleanCharacteristic extends SimulatedCharacteristic {
  BooleanCharacteristic(
      {@required uuid, @required bool initialValue, String convenienceName})
      : super(
            uuid: uuid,
            value: Uint8List.fromList([initialValue ? 1 : 0]),
            convenienceName: convenienceName);

  @override
  Future<void> write(Uint8List value, {bool sendNotification = true}) {
    int valueAsInt = value[0];
    if (valueAsInt != 0 && valueAsInt != 1) {
      return Future.error(SimulatedBleError(
          BleErrorCode.CharacteristicWriteFailed, "Unsupported value"));
    } else {
      return super.write(value); //this propagates value through the blemulator,
      // allowing you to react to changes done to this characteristic
    }
  }
}
