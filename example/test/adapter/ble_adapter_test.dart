import 'dart:async';

import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';

void main() {
  const peripheralName = 'Test peripheral name';
  const peripheralIdentifier = 'Test peripheral identifier';
  const peripheralRssi = -30;
  const peripheralLocalName = 'Test peripheral local name';

  MockBleManager bleManager = MockBleManager();
  MockBlemulator blemulator = MockBlemulator();
  BleAdapter bleAdapter = BleAdapter(bleManager, blemulator);
  StreamController<ScanResult> scanResultStreamController;

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
    when(advertisementData.localName).thenReturn(peripheralLocalName);
    return advertisementData;
  }

  MockScanResult setupMockScanResult(
      MockPeripheral peripheral, MockAdvertisementData advertisementData) {
    MockScanResult scanResult = MockScanResult();
    when(scanResult.peripheral).thenReturn(peripheral);
    when(scanResult.advertisementData).thenReturn(advertisementData);
    when(scanResult.rssi).thenReturn(peripheralRssi);
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

  group('Scanning', () {
    test('start scanning should cause library to start scanning', () {
      // when
      bleAdapter.startPeripheralScan();

      // then
      verify(bleManager.startPeripheralScan()).called(1);
    });

    test('stop scanning should cause library to stop scanning', () {
      // when
      bleAdapter.stopPeripheralScan();

      // then
      verify(bleManager.stopPeripheralScan()).called(1);
    });

    test('should emit peripheral upon receiving scan result', () {
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
        BlePeripheral(
            peripheralName,
            peripheralIdentifier,
            peripheralRssi,
            PeripheralConnectionState.disconnected,
            BlePeripheralCategoryResolver.categoryForName(peripheralName))
      ];
      expectLater(blePeripheralsStream, emitsInOrder(expectedResponse));
    });

    test(
        'should not emit peripheral upon receiving scan result without localName',
        () {
      // given
      Stream blePeripheralsStream = bleAdapter.startPeripheralScan();

      MockPeripheral peripheral = setupMockPeripheral();
      MockAdvertisementData advertisementData = setupMockAdvertisementData();
      MockScanResult scanResult =
          setupMockScanResult(peripheral, advertisementData);

      // when
      fireScanResultFromManager(scanResult);

      when(advertisementData.localName).thenReturn(null);
      fireScanResultFromManager(scanResult);

      when(advertisementData.localName).thenReturn(peripheralLocalName);
      fireScanResultFromManager(scanResult);

      // then
      final expectedBlePeripheral = BlePeripheral(
          peripheralName,
          peripheralIdentifier,
          peripheralRssi,
          PeripheralConnectionState.disconnected,
          BlePeripheralCategoryResolver.categoryForName(peripheralName));
      final expectedResponse = [expectedBlePeripheral, expectedBlePeripheral];
      expectLater(blePeripheralsStream, emitsInOrder(expectedResponse));
    });
  });
}
