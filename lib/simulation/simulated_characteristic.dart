part of blemulator;

class SimulatedCharacteristic {
  final String uuid;
  final int id;
  SimulatedService service;
  Uint8List _value;
  final String convenienceName;
  final bool isReadable;
  final bool isWritableWithResponse;
  final bool isWritableWithoutResponse;
  final bool isNotifiable;
  bool isNotifying;
  final bool isIndicatable;
  final Map<int, SimulatedDescriptor> _descriptors;

  StreamController<Uint8List> _streamController;

  SimulatedCharacteristic({
    @required String uuid,
    @required Uint8List value,
    this.convenienceName,
    this.isReadable = true,
    this.isWritableWithResponse = true,
    this.isWritableWithoutResponse = true,
    this.isNotifiable = false,
    this.isNotifying = false,
    this.isIndicatable = false,
    List<SimulatedDescriptor> descriptors = const [],
  })  : uuid = uuid.toLowerCase(),
        id = IdGenerator().nextId(),
        _descriptors = Map.fromIterable(
          descriptors,
          key: (descriptor) => descriptor.id,
          value: (descriptor) => descriptor,
        ) {
    _value = value;
    _descriptors.values
        .forEach((descriptor) => descriptor.attachToCharacteristic(this));
  }

  void attachToService(SimulatedService service) => this.service = service;

  Future<Uint8List> read() async => _value;

  Future<void> write(Uint8List value, {bool sendNotification = true}) async {
    this._value = value;
    if (sendNotification && _streamController?.hasListener == true)
      _streamController.sink.add(value);
  }

  Stream<Uint8List> monitor() {
    if (_streamController == null) {
      _streamController = StreamController.broadcast(
        onListen: () {
          isNotifying = true;
        },
        onCancel: () {
          isNotifying = false;
          _streamController.close();
          _streamController = null;
        },
      );
    }
    return _streamController.stream;
  }

  List<SimulatedDescriptor> descriptors() => _descriptors.values.toList();

  SimulatedDescriptor descriptor(int id) => _descriptors[id];

  SimulatedDescriptor descriptorByUuid(String uuid) =>
      _descriptors.values.firstWhere(
        (descriptor) => descriptor.uuid.toLowerCase() == uuid.toLowerCase(),
        orElse: () => null,
      );
}
