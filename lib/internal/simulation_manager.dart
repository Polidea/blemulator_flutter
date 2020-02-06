part of internal;

class SimulationManager extends SimulationManagerBaseWithErrorChecks
    with
        ClientManagingMixin,
        CharacteristicsMixin,
        DescriptorsMixin,
        ErrorChecksMixin,
        PeripheralConnectionMixin,
        PeripheralScanningMixing,
        DiscoveryMixin,
        PeripheralRssiMixin,
        PeripheralMtuMixin {
  SimulationManager(DartToPlatformBridge bridge) : super(bridge);

  void addSimulatedPeripheral(SimulatedPeripheral peripheral) {
    SimulatedPeripheral mapEntry =
        _peripherals.putIfAbsent(peripheral.id, () => peripheral);

    if (!identical(mapEntry, peripheral)) {
      print("Peripheral not added - there already"
          " exists a peripheral with the same id!");
    }
  }

  void removeAllSimulatedPeripherals() {
    _peripherals.clear();
    //TODO notify bridge?
  }
}
