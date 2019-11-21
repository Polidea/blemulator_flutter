import 'dart:async';

import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/develop/peripheral_list/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';

void main() {
  PeripheralListBloc peripheralListBloc;
  MockBleAdapter bleAdapter;
  StreamController<BlePeripheral> peripheralsStreamController;

  setUp(() {
    bleAdapter = MockBleAdapter();
    peripheralListBloc = PeripheralListBloc(bleAdapter);
    peripheralsStreamController = StreamController();

    when(bleAdapter.startPeripheralScan())
        .thenAnswer((_) => peripheralsStreamController.stream);
  });

  tearDown(() {
    peripheralListBloc.close();
    bleAdapter = null;
    peripheralsStreamController.close();
  });

  test('initial state is correct', () {
    expect(peripheralListBloc.initialState.peripherals, []);
    expect(peripheralListBloc.initialState.scanningEnabled, false);
  });

  test('close does not emit new states', () {
    // when
    peripheralListBloc.close();

    // then
    expectLater(
      peripheralListBloc,
      emitsInOrder([PeripheralListState.initial(), emitsDone]),
    );
  });

  group('Scanning Control', () {
    test(
        'emits state with scanningEnabled = true for StartPeripheralScan event',
        () {
      // given
      final PeripheralListEvent event = StartPeripheralScan();

      // when
      peripheralListBloc.add(event);

      // then
      final expectedResponse = [
        PeripheralListState.initial(),
        PeripheralListState(peripherals: [], scanningEnabled: true)
      ];
      expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
    });

    test(
      'emits state with scanningEnabled = false for StopPeripheralScan event'
      'after scanning was started before',
      () {
        // given
        final PeripheralListEvent startScanningEvent = StartPeripheralScan();
        final PeripheralListEvent stopScanningEvent = StopPeripheralScan();

        // when
        peripheralListBloc.add(startScanningEvent);
        peripheralListBloc.add(stopScanningEvent);

        // then
        final expectedResponse = [
          PeripheralListState.initial(),
          PeripheralListState(peripherals: [], scanningEnabled: true),
          PeripheralListState(peripherals: [], scanningEnabled: false)
        ];
        expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
      },
    );
  });

  group('Scanning events', () {
    test('emits state with updated peripherals for NewPeripheralScan event',
        () {
      // given
      final PeripheralListEvent startScanningEvent = StartPeripheralScan();
      final samplePeripheral = SampleBlePeripheral();

      // when
      peripheralListBloc.add(startScanningEvent);
      peripheralsStreamController.sink.add(samplePeripheral);

      // then
      final expectedResponse = [
        PeripheralListState.initial(),
        PeripheralListState(peripherals: [], scanningEnabled: true),
        PeripheralListState(
            peripherals: [samplePeripheral], scanningEnabled: true)
      ];
      expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
    });

    test(
        'emits state with updated peripherals for NewPeripheralScan events'
        'which contain different peripherals', () {
      // given
      final PeripheralListEvent startScanningEvent = StartPeripheralScan();
      final samplePeripheral = SampleBlePeripheral();
      final differentSamplePeripheral = SampleBlePeripheral.different();

      // when
      peripheralListBloc.add(startScanningEvent);
      peripheralsStreamController.sink.add(samplePeripheral);
      peripheralsStreamController.sink.add(differentSamplePeripheral);

      // then
      final expectedResponse = [
        PeripheralListState.initial(),
        PeripheralListState(peripherals: [], scanningEnabled: true),
        PeripheralListState(
            peripherals: [samplePeripheral], scanningEnabled: true),
        PeripheralListState(
            peripherals: [samplePeripheral, differentSamplePeripheral],
            scanningEnabled: true),
      ];
      expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
    });
  });

  test(
      'does not emit state with updated peripherals for NewPeripheralScan event'
      'that contains identical peripheral', () {
    // given
    final PeripheralListEvent startScanningEvent = StartPeripheralScan();
    final samplePeripheral = SampleBlePeripheral();
    final differentSamplePeripheral = SampleBlePeripheral.different();

    // when
    peripheralListBloc.add(startScanningEvent);
    peripheralsStreamController.sink.add(samplePeripheral);
    peripheralsStreamController.sink.add(samplePeripheral);
    peripheralsStreamController.sink.add(differentSamplePeripheral);

    // then
    final expectedResponse = [
      PeripheralListState.initial(),
      PeripheralListState(peripherals: [], scanningEnabled: true),
      PeripheralListState(
          peripherals: [samplePeripheral], scanningEnabled: true),
      PeripheralListState(
          peripherals: [samplePeripheral, differentSamplePeripheral],
          scanningEnabled: true),
    ];
    expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
  });
}

class SampleBlePeripheral extends BlePeripheral {
  SampleBlePeripheral({
    String name = 'Sample peripheral',
    String id = 'peripheral id',
    int rssi = -30,
    bool isConnected = false,
  }) : super(name, id, rssi, isConnected);

  SampleBlePeripheral.different({
    String name = 'Different sample peripheral',
    String id = 'different peripheral id',
    int rssi = -30,
    bool isConnected = false,
  }) : super(name, id, rssi, isConnected);
}
