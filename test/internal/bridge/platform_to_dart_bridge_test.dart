import 'dart:async';

import 'package:blemulator/src/internal.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart' as flutter_test;
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class SimulationManagerMock extends Mock implements SimulationManager {}

void main() {
  flutter_test.TestWidgetsFlutterBinding.ensureInitialized();
  const DEVICE_ID = 'id123';
  const REQUESTED_MTU = 33;
  const NEGOTIATED_MTU = 24;

  SimulationManagerMock simulationManager;
  PlatformToDartBridge platformToDartBridge;

  setUp(() {
    simulationManager = SimulationManagerMock();
    platformToDartBridge = PlatformToDartBridge(simulationManager);
  });

  group('MTU', () {
    test('should call request MTU with proper params from the call', () {
      //given
      var methodCall = MethodCall(DartMethodName.requestMtu, {
        SimulationArgumentName.deviceIdentifier: DEVICE_ID,
        SimulationArgumentName.mtu: REQUESTED_MTU
      });

      //when
      platformToDartBridge.dispatchPlatformCall(methodCall);

      //then
      verify(simulationManager.requestMtuForDevice(DEVICE_ID, REQUESTED_MTU));
    });

    test('should return returned MTU', () async {
      //given
      var methodCall = MethodCall(DartMethodName.requestMtu, {
        SimulationArgumentName.deviceIdentifier: DEVICE_ID,
        SimulationArgumentName.mtu: REQUESTED_MTU
      });

      when(simulationManager.requestMtuForDevice(DEVICE_ID, REQUESTED_MTU))
          .thenAnswer((_) => Future.value(NEGOTIATED_MTU));

      //when
      int negotiatedMtu = await platformToDartBridge.dispatchPlatformCall(methodCall);

      //then
      expect(negotiatedMtu, NEGOTIATED_MTU);
    });
  });
}
