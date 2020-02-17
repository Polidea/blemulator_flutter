part of blemulator;

class ScanInfo {
  int rssi;
  bool isConnectable;
  int txPowerLevel;

  Uint8List manufacturerData;
  Map<String, Uint8List> serviceData;
  List<String> serviceUuids;

  String localName;
  List<String> solicitedServiceUuids;
  List<String> overflowUuids;

  ScanInfo({
    this.rssi = defaultRssi,
    this.isConnectable = true,
    this.txPowerLevel,
    this.manufacturerData,
    this.serviceData,
    this.serviceUuids,
    this.localName,
    this.solicitedServiceUuids,
    this.overflowUuids,
  });
}

abstract class SimulatedPeripheral {
  final String name;
  final String id;
  Duration advertisementInterval;
  ScanInfo scanInfo;
  int mtu;

  Map<int, SimulatedService> _services;
  Map<int, SimulatedCharacteristic> _characteristics;
  Map<int, SimulatedDescriptor> _descriptors;
  final StreamController<FlutterBLELib.PeripheralConnectionState>
      _connectionStateStreamController;

  bool _isConnected = false;
  bool _discoveryDone = false;

  SimulatedPeripheral({
    @required this.name,
    @required this.id,
    @required this.advertisementInterval,
    @required List<SimulatedService> services,
    this.scanInfo,
  }) : _connectionStateStreamController = StreamController.broadcast() {
    mtu = defaultMtu;
    if (scanInfo == null) {
      this.scanInfo = ScanInfo();
    }

    if (scanInfo.serviceUuids == null) {
      scanInfo.serviceUuids = [];
    }

    scanInfo.serviceUuids.addAll(services
        .where((service) => service.isAdvertised)
        .map((service) => service.uuid));

    _services = Map.fromIterable(services, key: (service) => service.id);
    _characteristics = Map();
    _descriptors = Map();
    for (SimulatedService service in services) {
      for (SimulatedCharacteristic characteristic
          in service.characteristics()) {
        _characteristics.putIfAbsent(
          characteristic.id,
          () => characteristic,
        );
        for (SimulatedDescriptor descriptor in characteristic.descriptors()) {
          _descriptors.putIfAbsent(
            descriptor.id,
            () => descriptor,
          );
        }
      }
    }
  }

  Stream<FlutterBLELib.PeripheralConnectionState> get connectionStateStream {
    return _connectionStateStreamController.stream;
  }

  Stream<ScanResult> onScan({bool allowDuplicates = true}) async* {
    do {
      await Future.delayed(advertisementInterval);
      yield scanResult();
    } while (allowDuplicates);
  }

  ScanResult scanResult() {
    return ScanResult(scanInfo, this);
  }

  Future<bool> onConnectRequest() async {
    _connectionStateStreamController
        .add(FlutterBLELib.PeripheralConnectionState.connecting);
    return true;
  }

  Future<void> onDiscoveryRequest() async {}

  Future<void> onConnect() async {
    _isConnected = true;
    _connectionStateStreamController
        .add(FlutterBLELib.PeripheralConnectionState.connected);
  }

  Future<void> onDisconnect() async {
    _isConnected = false;
    _connectionStateStreamController
        .add(FlutterBLELib.PeripheralConnectionState.disconnected);
  }

  Future<void> onDiscovery() async {
    _discoveryDone = true;
  }

  bool get discoveryDone => _discoveryDone;

  bool isConnected() => _isConnected;

  List<SimulatedService> services() {
    return _services.values.toList();
  }

  SimulatedService service(int id) => _services[id];

  SimulatedCharacteristic characteristic(int characteristicIdentifier) =>
      _characteristics[characteristicIdentifier];

  SimulatedDescriptor descriptor(int descriptorIdentifier) =>
      _descriptors[descriptorIdentifier];

  bool hasService(int id) => _services.containsKey(id);

  bool hasServiceWithUuid(String uuid) {
    SimulatedService service = _services.values.firstWhere(
      (service) => service.uuid.toLowerCase() == uuid.toLowerCase(),
      orElse: () => null,
    );
    return service != null;
  }

  bool hasCharacteristic(int id) => _characteristics.containsKey(id);

  bool hasCharacteristicWithUuid(String uuid) {
    SimulatedCharacteristic characteristic = _characteristics.values.firstWhere(
      (characteristic) =>
          characteristic.uuid.toLowerCase() == uuid.toLowerCase(),
      orElse: () => null,
    );
    return characteristic != null;
  }

  bool hasDescriptor(int id) => _descriptors.containsKey(id);

  bool hasDescriptorWithUuid(
    String uuid, {
    String characteristicUuid,
    int characteristicId,
  }) {
    SimulatedDescriptor descriptor = _descriptors.values.firstWhere(
      (descriptor) {
        bool found = descriptor.uuid == uuid;
        if (characteristicUuid != null) {
          found = found && descriptor.characteristic.uuid == characteristicUuid;
        }
        if (characteristicId != null) {
          found = found && descriptor.characteristic.id == characteristicId;
        }

        return found;
      },
      orElse: () => null,
    );
    return descriptor != null;
  }

  SimulatedCharacteristic getCharacteristicForService(
    String serviceUuid,
    String characteristicUuid,
  ) {
    SimulatedCharacteristic targetCharacteristic;
    servicesLoop:
    for (SimulatedService service in services()) {
      SimulatedCharacteristic characteristic = service
          .characteristics()
          .firstWhere(
              (characteristic) => characteristic.uuid == characteristicUuid,
              orElse: () => null);
      if (characteristic != null) {
        targetCharacteristic = characteristic;
        break servicesLoop;
      }
    }
    return targetCharacteristic;
  }

  Future<int> rssi() async => scanInfo.rssi;

  Future<int> requestMtu(int requestedMtu) async {
    mtu = _negotiateMtu(requestedMtu);
    return mtu;
  }

  int _negotiateMtu(int requestedMtu) {
    int negotiatedMtu = max(min_mtu, requestedMtu);
    negotiatedMtu = min(max_mtu, negotiatedMtu);
    return negotiatedMtu;
  }
}
