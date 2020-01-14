import 'dart:async';

import 'package:blemulator_example/example_peripherals/generic_peripheral.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/example_peripherals/sensor_tag.dart';
import 'package:fimber/fimber.dart';
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

  Future<void> connect(String peripheralId) async {
    var peripheral = (await _bleManager.knownPeripherals([peripheralId])).first;
    await peripheral.connect(requestMtu: 0);
    bool isConnected = await peripheral.isConnected();
    Fimber.d("Is connected: $isConnected");
  }

  Future<int> requestMtu(String id, int mtu) async {
    var peripheral = (await _bleManager.knownPeripherals([id])).first;
    return peripheral.requestMtu(mtu);
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
      return BlePeripheral(
          scanResult.peripheral.name ??
              scanResult.advertisementData.localName ??
              'Unknown',
          scanResult.peripheral.identifier,
          scanResult.rssi,
          false,
          BlePeripheralCategoryResolver.categoryForScanResult(scanResult),
          scanResult.mtu
      );
    });
  }

  Future<void> _stopPeripheralScan() {
    return _bleManager.stopPeripheralScan();
  }

  void _setupSimulation() {
    _blemulator.addSimulatedPeripheral(SensorTag());
    _blemulator.addSimulatedPeripheral(SensorTag(id: "different id"));
    _blemulator
        .addSimulatedPeripheral(SensorTag(id: "yet another different id"));
    _blemulator.addSimulatedPeripheral(GenericPeripheral());
    _blemulator.simulate();
  }
}
