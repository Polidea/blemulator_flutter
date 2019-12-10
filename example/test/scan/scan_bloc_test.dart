import 'dart:async';

import 'package:blemulator_example/scan/bloc.dart';
import 'package:blemulator_example/scan/scan_result.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../mock/mocks.dart';
import '../mock/sample_scan_result.dart';

void main() {
  ScanBloc scanBloc;
  MockBleAdapter bleAdapter;
  StreamController<ScanResult> scanResultsStreamController;

  setUp(() {
    bleAdapter = MockBleAdapter();
    scanBloc = ScanBloc(bleAdapter);
    scanResultsStreamController = StreamController();

    when(bleAdapter.startPeripheralScan())
        .thenAnswer((_) => scanResultsStreamController.stream);
  });

  void receiveEvent(ScanEvent event) {
    scanBloc.add(event);
  }

  void fireScanResultFromAdapter(ScanResult scanResult) {
    scanResultsStreamController.sink.add(scanResult);
  }

  tearDown(() {
    scanBloc.close();
    bleAdapter = null;
    scanResultsStreamController.close();
  });

  test(
      'initial state contains empty scanResults array and scanningEnabled = false',
      () {
    expect(scanBloc.initialState.scanResults, []);
    expect(scanBloc.initialState.scanningEnabled, false);
  });

  test('close does not emit new states', () {
    // when
    scanBloc.close();

    // then
    expectLater(
      scanBloc,
      emitsInOrder([ScanState.initial(), emitsDone]),
    );
  });

  group('scanning', () {
    test('emits state with scanningEnabled = true for StartScan event', () {
      // given
      final ScanEvent event = StartScan();

      // when
      receiveEvent(event);

      // then
      final expectedResponse = [
        ScanState.initial(),
        ScanState(scanResults: [], scanningEnabled: true)
      ];
      expectLater(scanBloc, emitsInOrder(expectedResponse));
    });

    test(
      'emits state with scanningEnabled = false for StopScan event'
      'after scanning was started before',
      () {
        // given
        final startScanningEvent = StartScan();
        final stopScanningEvent = StopScan();

        // when
        receiveEvent(startScanningEvent);
        receiveEvent(stopScanningEvent);

        // then
        final expectedResponse = [
          ScanState.initial(),
          ScanState(scanResults: [], scanningEnabled: true),
          ScanState(scanResults: [], scanningEnabled: false),
        ];
        expectLater(scanBloc, emitsInOrder(expectedResponse));
      },
    );

    test('emits state with updated scanResults for NewScanResult event', () {
      // given
      final startScanningEvent = StartScan();
      final sampleScanResult = SampleScanResult();

      // when
      receiveEvent(startScanningEvent);

      fireScanResultFromAdapter(sampleScanResult);

      // then
      final expectedResponse = [
        ScanState.initial(),
        ScanState(scanResults: [], scanningEnabled: true),
        ScanState(
            scanResults: [sampleScanResult.viewModel()], scanningEnabled: true)
      ];
      expectLater(scanBloc, emitsInOrder(expectedResponse));
    });

    test(
        'emits state with updated peripherals for NewScanResult events'
        'which contain different peripherals', () {
      // given
      final startScanningEvent = StartScan();
      final sampleScanResult = SampleScanResult();
      final differentSampleScanResult = SampleScanResult.different();

      // when
      receiveEvent(startScanningEvent);

      fireScanResultFromAdapter(sampleScanResult);
      fireScanResultFromAdapter(differentSampleScanResult);

      // then
      final expectedResponse = [
        ScanState.initial(),
        ScanState(scanResults: [], scanningEnabled: true),
        ScanState(
            scanResults: [sampleScanResult.viewModel()], scanningEnabled: true),
        ScanState(scanResults: [
          sampleScanResult.viewModel(),
          differentSampleScanResult.viewModel(),
        ], scanningEnabled: true),
      ];
      expectLater(scanBloc, emitsInOrder(expectedResponse));
    });
  });

  test(
      'does not emit state with updated peripherals for NewScanResult event'
      'that contains identical scanResult', () {
    // given
    final startScanningEvent = StartScan();
    final sampleScanResult = SampleScanResult();
    final differentSampleScanResult = SampleScanResult.different();

    // when
    receiveEvent(startScanningEvent);

    fireScanResultFromAdapter(sampleScanResult);
    fireScanResultFromAdapter(sampleScanResult);
    fireScanResultFromAdapter(differentSampleScanResult);

    // then
    final expectedResponse = [
      ScanState.initial(),
      ScanState(scanResults: [], scanningEnabled: true),
      ScanState(
          scanResults: [sampleScanResult.viewModel()], scanningEnabled: true),
      ScanState(scanResults: [
        sampleScanResult.viewModel(),
        differentSampleScanResult.viewModel(),
      ], scanningEnabled: true),
    ];
    expectLater(scanBloc, emitsInOrder(expectedResponse));
  });
}
