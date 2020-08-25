import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:blemulator/blemulator.dart';

class BleAdapterInjector {
  static BleAdapter _instance;

  static BleAdapter get inject {
    _instance ??= BleAdapter(BleManager(), Blemulator());
    return _instance;
  }
}
