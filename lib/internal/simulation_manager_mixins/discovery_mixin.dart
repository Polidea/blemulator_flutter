part of internal;

mixin DiscoveryMixin on SimulationManagerBaseWithErrorChecks {
  Future<dynamic> discoverAllServicesAndCharacteristics(
          String deviceIdentifier, String transactionId) =>
      _saveCancelableOperation(transactionId, () async {
        await _errorIfUnknown(deviceIdentifier);
        await _errorIfNotConnected(deviceIdentifier);

        await _peripherals[deviceIdentifier].onDiscoveryRequest();
        await _peripherals[deviceIdentifier].onDiscovery();
        await _errorIfDisconnected(deviceIdentifier);
        return _peripherals[deviceIdentifier].services();
      });
}
