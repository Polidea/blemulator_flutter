import 'dart:async';

import 'package:blemulator/blemulator.dart';
import 'package:blemulator/internal/internal.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class DartToPlatformBridgeMock extends Mock implements DartToPlatformBridge {}

void main() {
  SimulationManager simulationManager =
      SimulationManager(DartToPlatformBridgeMock());

  group("handling cancellable platform calls", () {
    test(
        "handleCancelablePlatformCall triggers an expected error when there was pending transaction with given id",
        () async {
      Future<dynamic> instantOperationFuture = Future.value(123);

      Future<dynamic> longRunningOperationFuture =
          Future.delayed(Duration(milliseconds: 200), () => 123);

      expectLater(
        simulationManager.handleCancelablePlatformCall(
            longRunningOperationFuture, "1"),
        throwsA(equals(SimulatedBleError(
            BleErrorCode.OperationCancelled, "Operation cancelled"))),
      );

      await Future.delayed(Duration(milliseconds: 100));

      await simulationManager.handleCancelablePlatformCall(
          instantOperationFuture, "1");
    });

    test(
        "handleCancelablePlatformCall does not trigger error when transaction with given id has already finished",
        () async {
      Future<dynamic> instantOperationFuture = Future.value(123);

      Future<dynamic> longRunningOperationFuture =
          Future.delayed(Duration(milliseconds: 100), () => 456);

      expectLater(
        simulationManager.handleCancelablePlatformCall(
            longRunningOperationFuture, "1"),
        completion(equals(456)),
      );

      await Future.delayed(Duration(milliseconds: 200));

      await simulationManager.handleCancelablePlatformCall(
          instantOperationFuture, "1");
    });
  });
}
