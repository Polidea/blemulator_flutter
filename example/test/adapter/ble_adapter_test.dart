import 'dart:async';

import 'package:blemulator_example/develop/adapter/ble_adapter.dart';
import 'package:blemulator_example/develop/model/ble_peripheral.dart';
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

  tearDown(() {
    scanResultStreamController.close();
    reset(bleManager);
    reset(blemulator);
  });

  test('Calling BleAdapter constructor multiple times throws an error', () {
    expect(() => BleAdapter(bleManager, blemulator), throwsException);
  });

  group('Scanning', () {
    test('startPeripheralScan calls bleManager.startPeripheralScan', () {
      // when
      bleAdapter.startPeripheralScan();

      // then
      verify(bleManager.startPeripheralScan()).called(1);
    });

    test('stopPeripheralScan calls bleManager.stopPeripheralScan', () {
      // when
      bleAdapter.stopPeripheralScan();

      // then
      verify(bleManager.stopPeripheralScan()).called(1);
    });

    test('ScanResult is transformed to BlePeripheral', () {
      // given
      Stream blePeripheralsStream = bleAdapter.startPeripheralScan();

      MockPeripheral peripheral = setupMockPeripheral();
      MockAdvertisementData advertisementData = setupMockAdvertisementData();
      MockScanResult scanResult =
          setupMockScanResult(peripheral, advertisementData);

      // when
      scanResultStreamController.sink.add(scanResult);

      // then
      final expectedResponse = [
        BlePeripheral(
            peripheralName, peripheralIdentifier, peripheralRssi, false)
      ];
      expectLater(blePeripheralsStream, emitsInOrder(expectedResponse));
    });

    test('ScanResult with no localName is not returned on the stream', () {
      // given
      Stream blePeripheralsStream = bleAdapter.startPeripheralScan();

      MockPeripheral peripheral = setupMockPeripheral();
      MockAdvertisementData advertisementData = setupMockAdvertisementData();
      MockScanResult scanResult =
          setupMockScanResult(peripheral, advertisementData);

      // when
      scanResultStreamController.sink.add(scanResult);
      when(advertisementData.localName).thenReturn(null);
      scanResultStreamController.sink.add(scanResult);
      when(advertisementData.localName).thenReturn(peripheralLocalName);
      scanResultStreamController.sink.add(scanResult);

      // then
      final expectedBlePeripheral = BlePeripheral(
          peripheralName, peripheralIdentifier, peripheralRssi, false);
      final expectedResponse = [expectedBlePeripheral, expectedBlePeripheral];
      expectLater(blePeripheralsStream, emitsInOrder(expectedResponse));
    });
  });
}
