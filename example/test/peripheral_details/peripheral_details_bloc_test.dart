import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

import '../mock/mocks.dart';
import '../mock/sample_scan_result.dart';

void main() {
  PeripheralDetailsBloc peripheralDetailsBloc;
  MockBleAdapter bleAdapter;
  ScanResultViewModel scanResult;

  setUp(() {
    bleAdapter = MockBleAdapter();
    scanResult = SampleScanResult().viewModel();

    peripheralDetailsBloc =
        PeripheralDetailsBloc(bleAdapter, scanResult.identifier);
  });

  tearDown(() {
    peripheralDetailsBloc.close();
    bleAdapter = null;
  });

  test('initial state contains peripheral provided in the constructor', () {
    expect(peripheralDetailsBloc.initialState.scanResult, scanResult);
  });
}
