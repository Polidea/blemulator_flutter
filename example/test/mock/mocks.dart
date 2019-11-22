import 'package:blemulator/blemulator.dart';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:mockito/mockito.dart';

class MockBleAdapter extends Mock implements BleAdapter {}

class MockBleManager extends Mock implements BleManager {}

class MockBlemulator extends Mock implements Blemulator {}

class MockScanResult extends Mock implements ScanResult {}

class MockPeripheral extends Mock implements Peripheral {}

class MockAdvertisementData extends Mock implements AdvertisementData {}