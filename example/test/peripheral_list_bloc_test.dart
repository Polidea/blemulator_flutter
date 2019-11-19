import 'package:blemulator_example/develop/adapter/ble_adapter.dart';
import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/develop/peripheral_list/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockBleAdapter extends Mock implements BleAdapter {}

void main() {
  PeripheralListBloc peripheralListBloc;
  MockBleAdapter bleAdapter;

  setUp(() {
    bleAdapter = MockBleAdapter();
    peripheralListBloc = PeripheralListBloc(bleAdapter);
  });

  tearDown(() {
    peripheralListBloc.close();
    bleAdapter = null;
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
          PeripheralListState([], true)
        ];
        expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
      },
    );

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
          PeripheralListState([], true),
          PeripheralListState([], false),
        ];
        expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
      },
    );
  });

  group('Scanning events', () {
    test(
      'emits state with updated peripherals for NewPeripheralScan event',
      () {
        // given
        final PeripheralListEvent startScanningEvent = StartPeripheralScan();
        final samplePeripheral = SampleBlePeripheral();
        final PeripheralListEvent newScanEvent =
            NewPeripheralScan(samplePeripheral);

        // when
        peripheralListBloc.add(startScanningEvent);
        peripheralListBloc.add(newScanEvent);

        // then
        final expectedResponse = [
          PeripheralListState.initial(),
          PeripheralListState([], true),
          PeripheralListState([samplePeripheral], true)
        ];
        expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
      },
    );

    test(
      'emits state with updated peripherals for NewPeripheralScan events'
      'that contain different peripherals',
      () {
        // given
        final PeripheralListEvent startScanningEvent = StartPeripheralScan();
        final samplePeripheral = SampleBlePeripheral();
        final differentSamplePeripheral = SampleBlePeripheral.different();
        final PeripheralListEvent newScanEvent =
            NewPeripheralScan(samplePeripheral);
        final PeripheralListEvent differentNewScanEvent =
            NewPeripheralScan(differentSamplePeripheral);

        // when
        peripheralListBloc.add(startScanningEvent);
        peripheralListBloc.add(newScanEvent);
        peripheralListBloc.add(differentNewScanEvent);

        // then
        final expectedResponse = [
          PeripheralListState.initial(),
          PeripheralListState([], true),
          PeripheralListState([samplePeripheral], true),
          PeripheralListState(
              [samplePeripheral, differentSamplePeripheral], true)
        ];
        expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
      },
    );
  });

  test(
    'does not emit state with updated peripherals for NewPeripheralScan event'
    'that contains identical peripheral',
    () {
      // given
      final PeripheralListEvent startScanningEvent = StartPeripheralScan();
      final samplePeripheral = SampleBlePeripheral();
      final PeripheralListEvent newScanEvent =
          NewPeripheralScan(samplePeripheral);

      // when
      peripheralListBloc.add(startScanningEvent);
      peripheralListBloc.add(newScanEvent);
      peripheralListBloc.add(newScanEvent);
      peripheralListBloc.close();

      // then
      final expectedResponse = [
        PeripheralListState.initial(),
        PeripheralListState([], true),
        PeripheralListState([samplePeripheral], true),
        emitsDone
      ];
      expectLater(peripheralListBloc, emitsInOrder(expectedResponse));
    },
  );
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
