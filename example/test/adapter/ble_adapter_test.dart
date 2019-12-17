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
  StreamSubscription<BlePeripheral> blePeripheralsSubscription;

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

  void setupBlePeripheralSubscription() {
    blePeripheralsSubscription = bleAdapter.blePeripherals.listen((_) {});
  }

  void cancelBlePeripheralSubscription() {
    if (blePeripheralsSubscription != null) {
      blePeripheralsSubscription.cancel();
    }
  }

  tearDown(() {
    scanResultStreamController.close();
    cancelBlePeripheralSubscription();
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
      setupBlePeripheralSubscription();

      // then
      verify(bleManager.startPeripheralScan()).called(1);
    });

    test('stop scanning should cause library to stop scanning', () {
      // given
      setupBlePeripheralSubscription();

      // when
      blePeripheralsSubscription.cancel();

      // then
      verify(bleManager.stopPeripheralScan()).called(1);
    });

    test('should emit peripheral upon receiving scan result', () {
      // given
      setupBlePeripheralSubscription();

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
            false,
            BlePeripheralCategoryResolver.categoryForName(peripheralName))
      ];
      expectLater(bleAdapter.blePeripherals, emitsInOrder(expectedResponse));
    });
  });
}
