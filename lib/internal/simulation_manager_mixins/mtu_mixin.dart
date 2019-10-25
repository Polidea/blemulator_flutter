part of internal;

mixin PeripheralMtuMixin on SimulationManagerBaseWithErrorChecks {

  Future<int> requestMtuForDevice(String identifier, {int requestedMtu}) async {
    await _errorIfUnknown(identifier);
    await _errorIfNotConnected(identifier);

    int mtu = await _peripherals[identifier].requestMtu(requestedMtu: requestedMtu);
    await _errorIfDisconnected(identifier);
    return mtu;
  }
}