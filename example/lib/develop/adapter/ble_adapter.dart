import 'dart:async';

import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/example_peripheral.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:blemulator/blemulator.dart';

typedef void ScanEventOutputFunction(BlePeripheral peripheral);

class BleAdapter {
  static BleAdapter _instance;

  BleManager _bleManager;
  StreamSubscription _scanEventsSubscription;

  factory BleAdapter(BleManager bleManager) {
    if (_instance == null) {
      _instance = BleAdapter._internal(bleManager);
    } else {
      throw Exception('Constructor of BleAdapter called multiple times. '
          'Use BleAdapterInjector.inject() for injecting BleAdapter.');
    }
    return _instance;
  }

  BleAdapter._internal(this._bleManager) {
    // TODO: WIP - TEMPORARY PLACEMENT start
    Blemulator().addSimulatedPeripheral(SensorTag());
    Blemulator().addSimulatedPeripheral(SensorTag(id: "different id"));
    Blemulator()
        .addSimulatedPeripheral(SensorTag(id: "yet another different id"));
    Blemulator().simulate();
    // TODO: WIP - TEMPORARY PLACEMENT end

    _bleManager.createClient();
  }

  void startPeripheralScan(ScanEventOutputFunction scanEventOutput) {
    if (_scanEventsSubscription != null) {
      _scanEventsSubscription.cancel();
    }
    _scanEventsSubscription =
        _bleManager.startPeripheralScan().listen((ScanResult scanResult) {
      if (scanResult.advertisementData.localName != null) {
        final peripheral = BlePeripheral(
          scanResult.peripheral.name,
          scanResult.peripheral.identifier,
          scanResult.rssi,
          false,
        );
        scanEventOutput(peripheral);
      }
    });
  }

  Future<void> stopPeripheralScan() {
    _scanEventsSubscription.cancel();
    return _bleManager.stopPeripheralScan();
  }

  void dispose() {
    _scanEventsSubscription.cancel();
  }
}
