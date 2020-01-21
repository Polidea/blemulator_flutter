import 'dart:math';

import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/model/ble_service.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';
import '../mock/sample_ble_peripheral.dart';
import '../mock/sample_ble_service.dart';

void main() {
  PeripheralDetailsBloc peripheralDetailsBloc;
  MockBleAdapter bleAdapter;
  BlePeripheral peripheral;

  setUp(() {
    bleAdapter = MockBleAdapter();
    peripheral = SampleBlePeripheral();
    when(bleAdapter.discoverAndGetServicesCharacteristics(peripheral.id))
        .thenAnswer((_) => Future.value([]));

    peripheralDetailsBloc = PeripheralDetailsBloc(bleAdapter, peripheral);
  });

  tearDown(() {
    peripheralDetailsBloc.close();
    bleAdapter = null;
  });

  test('initial state contains peripheral provided in the constructor', () {
    expect(peripheralDetailsBloc.initialState.peripheral, peripheral);
  });

  test('should map ServicesFetchedEvent to PeripheralDetailsState', () async {
    // given
    List<BleService> bleServices = [SampleBleService()];
    ServicesFetchedEvent event = ServicesFetchedEvent(bleServices);
    List<BleServiceState> states =
        bleServices.map((service) => BleServiceState(service, false)).toList();

    PeripheralDetailsState expectedState = PeripheralDetailsState(
        peripheral: peripheral, bleServiceStates: states);

    // when
    peripheralDetailsBloc.add(event);

    // then
    expectLater(
      peripheralDetailsBloc,
      emitsThrough(equals(expectedState)),
    );
  });

  test('should map ServiceViewExpandedEvent to PeripheralDetailsState', () async {
    // given
    SampleBleService service = SampleBleService();
    BleServiceState newBleServiceState = BleServiceState(service, true);

    peripheralDetailsBloc.add(ServicesFetchedEvent([service]));

    PeripheralDetailsState expectedState = PeripheralDetailsState(
        peripheral: peripheral, bleServiceStates: [newBleServiceState]);

    // when
    peripheralDetailsBloc.add(ServiceViewExpandedEvent(0));

    // then
    await expectLater(
      peripheralDetailsBloc,
      emitsThrough(equals(expectedState)),
    );
  });
}
