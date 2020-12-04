part of internal;

mixin PeripheralConnectionMixin on SimulationManagerBaseWithErrorChecks {
  final Map<String, StreamSubscription> _connectionStateSubscriptions = {};

  Future<void> _connectToDevice(String identifier) async {
    await _errorIfUnknown(identifier);

    addConnectionStateObserverIfNeeded(identifier);

    await _errorIfConnected(identifier);

    await _errorIfCannotConnect(identifier);
    await _peripherals[identifier].onConnect();

    if (Platform.isIOS) {
      await _peripherals[identifier].requestMtu(max_mtu);
    }
  }

  void addConnectionStateObserverIfNeeded(String identifier) {
    _connectionStateSubscriptions.putIfAbsent(
        identifier,
        () => _peripherals[identifier]
                .connectionStateStream
                .listen((connectionState) {
              _bridge.publishConnectionState(
                  _peripherals[identifier], connectionState);

              if (connectionState == flutter_ble_lib.PeripheralConnectionState.disconnected) {
                _connectionStateSubscriptions[identifier].cancel();
                _connectionStateSubscriptions.remove(identifier);
              }
            }));
  }

  Future<bool> _isDeviceConnected(String identifier) async {
    await _errorIfUnknown(identifier);
    return _peripherals[identifier].isConnected();
  }

  Future<void> _disconnectOrCancelConnection(String identifier) async {
    await _errorIfUnknown(identifier);
    await _errorIfNotConnected(identifier);
    return _peripherals[identifier].onDisconnect();
  }
}
