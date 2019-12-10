import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';
import '../mock/sample_peripheral_details.dart';

void main() {
  PeripheralDetailsBloc peripheralDetailsBloc;
  MockBleAdapter bleAdapter;
  PeripheralDetails peripheralDetails;

  setUp(() {
    bleAdapter = MockBleAdapter();
    peripheralDetails = SamplePeripheralDetails();

    when(bleAdapter
            .peripheralDetailsForIdentifier(peripheralDetails.identifier))
        .thenReturn(peripheralDetails);

    peripheralDetailsBloc =
        PeripheralDetailsBloc(bleAdapter, peripheralDetails.identifier);
  });

  tearDown(() {
    peripheralDetailsBloc.close();
    bleAdapter = null;
  });

  test('initial state contains peripheral provided in the constructor', () {
    expect((peripheralDetailsBloc.initialState as PeripheralFoundState).peripheralDetails,
        peripheralDetails.viewModel());
  });
}
