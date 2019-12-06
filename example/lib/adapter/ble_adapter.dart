import 'dart:async';

import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/example_peripheral.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:blemulator/blemulator.dart';

abstract class BleAdapterException implements Exception {
  final String _message;

  String get message => _message;

  BleAdapterException(this._message);
}

class BleAdapterConstructorException extends BleAdapterException {
  BleAdapterConstructorException()
      : super('Constructor of BleAdapter called multiple times. '
            'Use BleAdapterInjector.inject() for injecting BleAdapter.');
}

class BleAdapter {
  static BleAdapter _instance;

  BleManager _bleManager;
  Blemulator _blemulator;

  Map<String, ScanResult> _scanResults = {};

  factory BleAdapter(BleManager bleManager, Blemulator blemulator) {
    if (_instance == null) {
      _instance = BleAdapter._internal(bleManager, blemulator);
    } else {
      throw BleAdapterConstructorException();
    }
    return _instance;
  }

  BleAdapter._internal(this._bleManager, this._blemulator) {
    _setupSimulation();
    _bleManager.createClient();
  }

  Stream<BlePeripheral> startPeripheralScan() {
    return _bleManager.startPeripheralScan().map((scanResult) {
      _scanResults.update(
        scanResult.peripheral.identifier,
        (_) => scanResult,
        ifAbsent: () => scanResult,
      );
      return BlePeripheral.fromScanResult(scanResult);
      ;
    });
  }

  Future<void> stopPeripheralScan() {
    return _bleManager.stopPeripheralScan();
  }

  void _setupSimulation() {
    _blemulator.addSimulatedPeripheral(SensorTag());
    _blemulator.addSimulatedPeripheral(SensorTag(id: "different id"));
    _blemulator
        .addSimulatedPeripheral(SensorTag(id: "yet another different id"));
    // Primitive override, since SensorTag is only recognized by name currently
    _blemulator.addSimulatedPeripheral(
        SensorTag(name: 'Not a SensorTag', id: 'not-sensor-tag-id'));
    _blemulator.simulate();
  }
}
