import 'dart:async';
import 'dart:typed_data';

import 'package:blemulator/blemulator.dart';
import 'package:blemulator/internal/internal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' as prefix0;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class SimulationManagerMock extends Mock implements SimulationManager {}

void main() {
  const DEVICE_ID = "id123";
  const REQUESTED_MTU = 33;
  const NEGOTIATED_MTU = 24;

  SimulationManagerMock simulationManager;
  PlatformToDartBridge platformToDartBridge;

  setUp(() {
    simulationManager = SimulationManagerMock();
    platformToDartBridge = PlatformToDartBridge(simulationManager);
    when(simulationManager.cancelMonitoringTransactionIfExists("1"))
        .thenAnswer((_) {
      return;
    });
  });

  group("MTU", () {
    test("should call request MTU with proper params from the call", () {
      //given
      MethodCall methodCall = MethodCall(DartMethodName.requestMtu, {
        SimulationArgumentName.deviceIdentifier: DEVICE_ID,
        SimulationArgumentName.mtu: REQUESTED_MTU
      });

      //when
      platformToDartBridge.handleCall(methodCall);

      //then
      verify(simulationManager.requestMtuForDevice(DEVICE_ID, REQUESTED_MTU));
    });

    test("should return returned MTU", () async {
      //given
      MethodCall methodCall = MethodCall(DartMethodName.requestMtu, {
        SimulationArgumentName.deviceIdentifier: DEVICE_ID,
        SimulationArgumentName.mtu: REQUESTED_MTU
      });

      when(simulationManager.requestMtuForDevice(DEVICE_ID, REQUESTED_MTU))
          .thenAnswer((_) => Future.value(NEGOTIATED_MTU));

      //when
      int negotiatedMtu = await platformToDartBridge.handleCall(methodCall);

      //then
      expect(negotiatedMtu, NEGOTIATED_MTU);
    });
  });

  group("cancelTransaction", () {
    test(
        "cancelTransaction throws expected error when there was pending transaction with given id",
        () async {
      MethodCall cancellingMethodCall = MethodCall(
          DartMethodName.cancelTransaction,
          {SimulationArgumentName.transactionId: "1"});

      MethodCall discoverServicesMethodCall =
          MethodCall(DartMethodName.discoverAllServicesAndCharacteristics, {
        SimulationArgumentName.id: DEVICE_ID,
        SimulationArgumentName.transactionId: "1",
      });
      when(simulationManager.discoverAllServicesAndCharacteristics(DEVICE_ID))
          .thenAnswer(
              (_) => Future.delayed(Duration(milliseconds: 1000), () => []));

      expectLater(
        platformToDartBridge.handleCall(discoverServicesMethodCall),
        throwsA(equals(SimulatedBleError(
            BleErrorCode.OperationCancelled, "Operation cancelled"))),
      );

      await Future.delayed(Duration(milliseconds: 500));

      platformToDartBridge.handleCall(cancellingMethodCall);
    });

    test(
        "cancelTransaction does not throw error when there was no pending transaction with given id",
        () async {
      MethodCall cancellingMethodCall = MethodCall(
          DartMethodName.cancelTransaction,
          {SimulationArgumentName.transactionId: "1"});

      MethodCall discoverServicesMethodCall =
          MethodCall(DartMethodName.discoverAllServicesAndCharacteristics, {
        SimulationArgumentName.id: DEVICE_ID,
        SimulationArgumentName.transactionId: "1",
      });
      when(simulationManager.discoverAllServicesAndCharacteristics(DEVICE_ID))
          .thenAnswer((_) => Future.delayed(
                Duration(milliseconds: 100),
                () => Future.value(<SimulatedService>[]),
              ));

      expectLater(
        platformToDartBridge.handleCall(discoverServicesMethodCall),
        completion(equals([])),
      );

      Future.delayed(
        Duration(milliseconds: 200),
        () => platformToDartBridge.handleCall(cancellingMethodCall),
      );
    });
  });
}
