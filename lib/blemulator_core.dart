part of blemulator;

/// Entry point for using the simulator
class Blemulator {
  static final Blemulator _instance = Blemulator._internal();

  DartToPlatformBridge _toPlatformBridge;
  SimulationManager _simulationManager;
  // ignore: unused_field
  PlatformToDartBridge _toDartBridge;

  factory Blemulator() => _instance;

  Blemulator._internal() {
    _toPlatformBridge = DartToPlatformBridge();
    _simulationManager = SimulationManager(_toPlatformBridge);
    _toDartBridge = PlatformToDartBridge(_simulationManager);
  }

  /// Switches the implementation of the native adapter to simulation
  ///
  /// Must be called before BleManager.createClient()!
  Future<void> simulate() => _toPlatformBridge.simulate();

  /// Adds peripheral to simulation
  void addSimulatedPeripheral(SimulatedPeripheral peripheral) {
    _simulationManager.addSimulatedPeripheral(peripheral);
  }
}
