import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';
import '../mock/sample_ble_peripheral.dart';

void main() {
  PeripheralDetailsBloc peripheralDetailsBloc;
  MockBleAdapter bleAdapter;
  MockBlePeripheralRepository blePeripheralRepository;
  BlePeripheral peripheral;

  setUp(() {
    bleAdapter = MockBleAdapter();
    blePeripheralRepository = MockBlePeripheralRepository();
    peripheral = SampleBlePeripheral();

    when(blePeripheralRepository.blePeripheral).thenReturn(peripheral);

    peripheralDetailsBloc =
        PeripheralDetailsBloc(bleAdapter, blePeripheralRepository);
  });

  tearDown(() {
    peripheralDetailsBloc.close();
    bleAdapter = null;
    blePeripheralRepository = null;
  });

  test('initial state is correct', () {
    expect(peripheralDetailsBloc.initialState.peripheral,
        blePeripheralRepository.blePeripheral);
  });

  test('close does not emit new states', () {
    // when
    peripheralDetailsBloc.close();

    // then
    expectLater(
      peripheralDetailsBloc,
      emitsInOrder([PeripheralDetailsState(peripheral: peripheral), emitsDone]),
    );
  });
}
