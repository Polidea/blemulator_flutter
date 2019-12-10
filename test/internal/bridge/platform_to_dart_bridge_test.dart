import 'dart:async';

import 'package:blemulator/internal/internal.dart';
import 'package:flutter/services.dart';
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
    when(simulationManager.discoverAllServicesAndCharacteristics(DEVICE_ID))
        .thenAnswer((_) => Future.value([]));
  });

  group("handling platform call", () {
    test("should handle cancellable transaction using simulation manager when call contains non-null transactionId but call is not cancelTransaction", () {
      MethodCall methodCall = MethodCall(DartMethodName.discoverAllServicesAndCharacteristics, {
        SimulationArgumentName.id: DEVICE_ID,
        SimulationArgumentName.transactionId: "123",
      });

      //when
      platformToDartBridge.handleCall(methodCall);

      //then
      verify(simulationManager.handleCancelablePlatformCall(any, "123"));
    });

    test("should not handle cancellable transaction using simulation manager when call contains non-null transactionId and call is cancelTransaction", () {
      MethodCall methodCall = MethodCall(DartMethodName.cancelTransaction, {
        SimulationArgumentName.transactionId: "123",
      });

      //when
      platformToDartBridge.handleCall(methodCall);

      //then
      verifyNever(simulationManager.handleCancelablePlatformCall(any, "123"));
    });

    test("should handle cancellable transaction using simulation manager when call contains null transactionId and call is not cancelTransaction", () {
      MethodCall methodCall = MethodCall(DartMethodName.discoverAllServicesAndCharacteristics, {
        SimulationArgumentName.id: DEVICE_ID,
        SimulationArgumentName.transactionId: null,
      });

      //when
      platformToDartBridge.handleCall(methodCall);

      //then
      verify(simulationManager.handleCancelablePlatformCall(any, null));
    });

    test("should handle cancellable transaction using simulation manager when call does not contain transactionId", () {
      MethodCall methodCall = MethodCall(DartMethodName.discoverAllServicesAndCharacteristics, {
        SimulationArgumentName.id: DEVICE_ID,
      });

      //when
      platformToDartBridge.handleCall(methodCall);

      //then
      verifyNever(simulationManager.handleCancelablePlatformCall(any, any));
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
}
