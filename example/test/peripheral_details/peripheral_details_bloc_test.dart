import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mocks.dart';
import '../mock/sample_peripheral_details.dart';
import '../mock/sample_scan_result.dart';

void main() {
  PeripheralDetailsBloc peripheralDetailsBloc;
  MockBleAdapter bleAdapter;
  PeripheralDetails peripheralDetails;

  setUp(() {
    bleAdapter = MockBleAdapter();
    peripheralDetails = SamplePeripheralDetails();

    peripheralDetailsBloc =
        PeripheralDetailsBloc(bleAdapter, peripheralDetails);
  });

  tearDown(() {
    peripheralDetailsBloc.close();
    bleAdapter = null;
  });

  test('initial state contains peripheral provided in the constructor', () {
    expect(peripheralDetailsBloc.initialState.peripheralDetails,
        peripheralDetails.viewModel());
  });
}
