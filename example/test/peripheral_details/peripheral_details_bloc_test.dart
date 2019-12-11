import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/peripheral_info.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';
import '../mock/sample_peripheral_details.dart';

void main() {
  PeripheralDetailsBloc peripheralDetailsBloc;
  MockBleAdapter bleAdapter;
  PeripheralInfo peripheralInfo;

  setUp(() {
    bleAdapter = MockBleAdapter();
    peripheralInfo = SamplePeripheralInfo();

    when(bleAdapter
            .peripheralDetailsForIdentifier(peripheralInfo.identifier))
        .thenReturn(peripheralInfo);

    peripheralDetailsBloc =
        PeripheralDetailsBloc(bleAdapter, peripheralInfo.identifier);
  });

  tearDown(() {
    peripheralDetailsBloc.close();
    bleAdapter = null;
  });

  test('initial state contains peripheral provided in the constructor', () {
    expect((peripheralDetailsBloc.initialState as PeripheralFoundState).peripheralInfo,
        peripheralInfo.viewModel());
  });
}
