part of internal;

mixin PeripheralMtuMixin on SimulationManagerBaseWithErrorChecks {
  Future<int> requestMtuForDevice(String identifier, int requestedMtu) async {
    await _errorIfUnknown(identifier);
    await _errorIfNotConnected(identifier);

    int mtu;
    if (Platform.isIOS) {
      mtu = await _peripherals[identifier].requestMtu(max_mtu);
    } else {
      mtu = await _peripherals[identifier].requestMtu(requestedMtu);
    }

    await _errorIfDisconnected(identifier);
    return mtu;
  }
}
