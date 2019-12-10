import 'dart:async';

import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/util/peripheral_category_resolver.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart' as FlutterBleLib;
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';

void main() {
  const peripheralName = 'Test peripheral name';
  const peripheralIdentifier = 'Test peripheral identifier';
  const rssi = -30;
  const mtu = 23;
  const isConnectable = true;
  const localName = 'Test peripheral local name';

  MockBleManager bleManager = MockBleManager();
  MockBlemulator blemulator = MockBlemulator();
  BleAdapter bleAdapter = BleAdapter(bleManager, blemulator);
  StreamController<FlutterBleLib.ScanResult> scanResultStreamController;

  setUp(() {
    scanResultStreamController = StreamController();

    when(bleManager.startPeripheralScan())
        .thenAnswer((_) => scanResultStreamController.stream);
  });

  MockPeripheral setupMockPeripheral() {
    MockPeripheral peripheral = MockPeripheral();
    when(peripheral.name).thenReturn(peripheralName);
    when(peripheral.identifier).thenReturn(peripheralIdentifier);
    return peripheral;
  }

  MockAdvertisementData setupMockAdvertisementData() {
    MockAdvertisementData advertisementData = MockAdvertisementData();
    when(advertisementData.localName).thenReturn(localName);
    return advertisementData;
  }

  MockScanResult setupMockScanResult(
      MockPeripheral peripheral, MockAdvertisementData advertisementData) {
    MockScanResult scanResult = MockScanResult();
    when(scanResult.peripheral).thenReturn(peripheral);
    when(scanResult.advertisementData).thenReturn(advertisementData);
    when(scanResult.rssi).thenReturn(rssi);
    when(scanResult.mtu).thenReturn(mtu);
    when(scanResult.isConnectable).thenReturn(isConnectable);
    return scanResult;
  }

  void fireScanResultFromManager(MockScanResult scanResult) {
    scanResultStreamController.sink.add(scanResult);
  }

  tearDown(() {
    scanResultStreamController.close();
    reset(bleManager);
    reset(blemulator);
  });

  test('calling BleAdapter constructor more than once should throw an error',
      () {
    expect(() => BleAdapter(bleManager, blemulator),
        throwsA(isInstanceOf<BleAdapterConstructorException>()));
  });

  group('scanning', () {
    test('start should cause library to start scanning', () {
      // when
      bleAdapter.startPeripheralScan();

      // then
      verify(bleManager.startPeripheralScan()).called(1);
    });

    test('stop should cause library to stop scanning', () {
      // when
      bleAdapter.stopPeripheralScan();

      // then
      verify(bleManager.stopPeripheralScan()).called(1);
    });

    test('should emit scanResult upon receiving scanResult from library', () {
      // given
      Stream blePeripheralsStream = bleAdapter.startPeripheralScan();

      MockPeripheral peripheral = setupMockPeripheral();
      MockAdvertisementData advertisementData = setupMockAdvertisementData();
      MockScanResult scanResult =
          setupMockScanResult(peripheral, advertisementData);

      // when
      fireScanResultFromManager(scanResult);

      // then
      final expectedResponse = [
        ScanResult(
            peripheralName,
            peripheralIdentifier,
            PeripheralCategoryResolver.categoryForPeripheralName(
                peripheralName),
            rssi,
            mtu,
            isConnectable,
            advertisementData)
      ];
      expectLater(blePeripheralsStream, emitsInOrder(expectedResponse));
    });
  });
}
