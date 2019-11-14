import 'dart:async';

import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

typedef void ScanEventOutputFunction(BlePeripheral peripheral);

class PeripheralListRepository {
  BleManager _bleManager;
  StreamSubscription _scanEventsSubscription;

  PeripheralListRepository(this._bleManager) {
    _bleManager.createClient();
  }

  void startPeripheralScan({ScanEventOutputFunction scanEventOutput}) {
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
}
