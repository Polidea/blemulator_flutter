import 'dart:async';

import 'package:blemulator_example/adapter/peripheral_container.dart';
import 'package:blemulator_example/example_peripheral.dart';
import 'package:blemulator_example/peripheral_details/peripheral_info.dart';
import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/util/peripheral_category_resolver.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart' as FlutterBleLib;
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

abstract class BleAdapterError extends Error {}

class PeripheralUnavailableError extends BleAdapterError {}

class BleAdapter {
  static BleAdapter _instance;

  FlutterBleLib.BleManager _bleManager;
  Blemulator _blemulator;

  Map<String, PeripheralContainer> _peripheralContainers = {};

  factory BleAdapter(
      FlutterBleLib.BleManager bleManager, Blemulator blemulator) {
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

  Stream<ScanResult> startPeripheralScan() {
    return _bleManager.startPeripheralScan().map((scanResult) {
      _peripheralContainers.update(
        scanResult.peripheral.identifier,
        (_) => PeripheralContainer(peripheral: scanResult.peripheral),
        ifAbsent: () => PeripheralContainer(peripheral: scanResult.peripheral),
      );
      return _mapScanResult(scanResult);
    });
  }

  Future<void> stopPeripheralScan() {
    return _bleManager.stopPeripheralScan();
  }

  PeripheralInfo peripheralInfoForIdentifier(String identifier) {
    PeripheralContainer peripheral = _peripheralContainers[identifier];
    if (peripheral != null) {
      return PeripheralInfo(
        peripheral.peripheral.name ??
            peripheral.advertisementData.localName,
        peripheral.peripheral.identifier,
        PeripheralCategoryResolver.categoryForPeripheralName(
            peripheral.peripheral.name),
      );
    } else {
      throw PeripheralUnavailableError();
    }
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

  ScanResult _mapScanResult(FlutterBleLib.ScanResult scanResult) {
    return ScanResult(
      scanResult.peripheral.name ?? scanResult.advertisementData.localName,
      scanResult.peripheral.identifier,
      PeripheralCategoryResolver.categoryForPeripheralName(
          scanResult.peripheral.name),
      scanResult.rssi,
      scanResult.mtu,
      scanResult.isConnectable,
    );
  }
}
