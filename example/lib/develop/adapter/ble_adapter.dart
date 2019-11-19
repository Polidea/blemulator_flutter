import 'dart:async';

import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/example_peripheral.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:blemulator/blemulator.dart';

typedef void ScanEventOutputFunction(BlePeripheral peripheral);

class BleAdapter {
  static BleAdapter _instance;

  BleManager _bleManager;
  Blemulator _blemulator;

  factory BleAdapter(BleManager bleManager, Blemulator blemulator) {
    if (_instance == null) {
      _instance = BleAdapter._internal(bleManager, blemulator);
    } else {
      throw Exception('Constructor of BleAdapter called multiple times. '
          'Use BleAdapterInjector.inject() for injecting BleAdapter.');
    }
    return _instance;
  }

  BleAdapter._internal(this._bleManager, this._blemulator) {
    _setupSimulation();
    _createClient();
  }

  Stream<BlePeripheral> startPeripheralScan() {
    return _bleManager.startPeripheralScan().transform(
      new StreamTransformer<ScanResult, BlePeripheral>.fromHandlers(
        handleData: (ScanResult scanResult, EventSink<BlePeripheral> sink) {
          if (scanResult.advertisementData.localName != null) {
            final peripheral = BlePeripheral(
              scanResult.peripheral.name,
              scanResult.peripheral.identifier,
              scanResult.rssi,
              false,
            );
            sink.add(peripheral);
          }
        },
      ),
    );
  }

  Future<void> stopPeripheralScan() {
    return _bleManager.stopPeripheralScan();
  }

  void _createClient() {
    _bleManager.createClient();
  }

  void _setupSimulation() {
    _blemulator.addSimulatedPeripheral(SensorTag());
    _blemulator.addSimulatedPeripheral(SensorTag(id: "different id"));
    _blemulator
        .addSimulatedPeripheral(SensorTag(id: "yet another different id"));
    _blemulator.simulate();
  }
}
