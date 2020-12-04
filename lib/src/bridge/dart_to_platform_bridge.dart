part of internal;

class DartToPlatformBridge {
  MethodChannel _dartToPlatformChannel;

  DartToPlatformBridge() {
    _dartToPlatformChannel = MethodChannel(ChannelName.dartToPlatform);
  }

  Future<void> simulate() =>
      _dartToPlatformChannel.invokeMethod(PlatformMethodName.simulate);

  Future<void> publishScanResult(ScanResult scanResult) =>
      _dartToPlatformChannel.invokeMethod(
          SimulationPlatformMethodName.publishScanResult, <String, dynamic>{
        SimulationArgumentName.name: scanResult.name,
        SimulationArgumentName.id: scanResult.id,
        SimulationArgumentName.rssi: scanResult.rssi,
        SimulationArgumentName.isConnectable: scanResult.isConnectable,
        SimulationArgumentName.txPowerLevel: scanResult.txPowerLevel,
        SimulationArgumentName.manufacturerData: scanResult.manufacturerData,
        SimulationArgumentName.serviceData: scanResult.serviceData,
        SimulationArgumentName.serviceUuids: scanResult.serviceUuids,
        SimulationArgumentName.localName: scanResult.localName,
        SimulationArgumentName.solicitedServiceUuids:
            scanResult.solicitedServiceUuids,
        SimulationArgumentName.overflowUuids: scanResult.overflowUuids,
      });

  Future<void> publishConnectionState(SimulatedPeripheral peripheral,
      flutter_ble_lib.PeripheralConnectionState connectionState) =>
      _dartToPlatformChannel.invokeMethod(
          SimulationPlatformMethodName.publishConnectionState,
          <String, dynamic>{
            SimulationArgumentName.id: peripheral.id,
            SimulationArgumentName.connectionState:
                _connectionStateToString(connectionState),
          });

  String _connectionStateToString(flutter_ble_lib.PeripheralConnectionState state) {
    switch (state) {
      case flutter_ble_lib.PeripheralConnectionState.connecting:
        return NativeConnectionState.connecting;
      case flutter_ble_lib.PeripheralConnectionState.connected:
        return NativeConnectionState.connected;
      case flutter_ble_lib.PeripheralConnectionState.disconnecting:
        return NativeConnectionState.disconnecting;
      case flutter_ble_lib.PeripheralConnectionState.disconnected:
        return NativeConnectionState.disconnected;
      default:
        return null;
    }
  }

  Future<void> publishCharacteristicUpdate(
    String peripheralId,
    SimulatedCharacteristic characteristic,
    Uint8List value,
    String transactionId,
  ) =>
      _dartToPlatformChannel.invokeMethod(
        SimulationPlatformMethodName.publishCharacteristicUpdate,
        mapToCharacteristicJson(
          peripheralId,
          characteristic,
          value,
        )..putIfAbsent(Metadata.transactionId, () => transactionId),
      );

  Future<void> publishCharacteristicMonitoringError(
    String peripheralId,
    int characteristicId,
    SimulatedBleError bleError,
    String transactionId,
  ) =>
      _dartToPlatformChannel.invokeMethod(
          SimulationPlatformMethodName.publishCharacteristicMonitoringError,
          <String, dynamic>{
            Metadata.characteristicId: characteristicId,
            Metadata.errorCode: bleError.errorCode,
            Metadata.reason: bleError.reason,
            Metadata.transactionId: transactionId,
          });
}
