import 'dart:async';

import 'package:blemulator_example/example_peripherals/generic_peripheral.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/example_peripherals/sensor_tag.dart';
import 'package:blemulator_example/model/ble_service.dart';
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

  StreamController<BlePeripheral> _blePeripheralsController;

  Stream<BlePeripheral> get blePeripherals => _blePeripheralsController.stream;

  final Map<String, Peripheral> _scannedPeripherals = {};

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
    _setupBlePeripheralsController();
  }

  void _setupBlePeripheralsController() {
    _blePeripheralsController = StreamController.broadcast(
      onListen: () {
        _blePeripheralsController.addStream(_startPeripheralScan());
      },
      onCancel: () {
        _stopPeripheralScan();
      },
    );
  }

  Stream<BlePeripheral> _startPeripheralScan() {
    return _bleManager.startPeripheralScan().map((scanResult) {
      _scannedPeripherals.putIfAbsent(
          scanResult.peripheral.identifier, () => scanResult.peripheral);
      return BlePeripheral(
        scanResult.peripheral.name ??
            scanResult.advertisementData.localName ??
            'Unknown',
        scanResult.peripheral.identifier,
        scanResult.rssi,
        false,
        BlePeripheralCategoryResolver.categoryForScanResult(scanResult),
      );
    });
  }

  Future<void> _stopPeripheralScan() {
    return _bleManager.stopPeripheralScan();
  }

  void _setupSimulation() {
    _blemulator.addSimulatedPeripheral(SensorTag());
    _blemulator.addSimulatedPeripheral(SensorTag(id: 'different id'));
    _blemulator
        .addSimulatedPeripheral(SensorTag(id: 'yet another different id'));
    _blemulator.addSimulatedPeripheral(GenericPeripheral());
    _blemulator.simulate();
  }

  Future<List<BleService>> discoverAndGetServicesCharacteristics(
      String peripheralId) async {
    // TODO remove connect() call when connectivity handling is implemented
    await _scannedPeripherals[peripheralId].connect();
    await _scannedPeripherals[peripheralId]
        .discoverAllServicesAndCharacteristics();

    var bleServices = <BleService>[];
    for (var service
        in await _scannedPeripherals[peripheralId].services()) {
      var serviceCharacteristics =
          await service.characteristics();
      var bleCharacteristics = serviceCharacteristics
          .map(
            (characteristic) =>
                BleCharacteristic.fromCharacteristic(characteristic),
          )
          .toList();
      bleServices.add(BleService(service.uuid, bleCharacteristics));
    }

    // TODO remove when connectivity handling is implemented
    await _scannedPeripherals[peripheralId].disconnectOrCancelConnection();

    return bleServices;
  }
}
