import 'package:blemulator_example/develop/adapter/ble_adapter.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class BleAdapterInjector {
  static BleAdapter _instance;

  static BleAdapter get inject {
    if (_instance == null) {
      _instance = BleAdapter(BleManager());
    }
    return _instance;
  }
}