part of blemulator;

class SimulatedDescriptor {
  final String uuid;
  final String convenienceName;
  final bool readable;
  final bool writable;
  Uint8List _value;
  final int id;
  SimulatedCharacteristic characteristic;
  StreamController<Uint8List> _streamController;

  SimulatedDescriptor({
    @required String uuid,
    @required Uint8List value,
    this.convenienceName,
    this.readable = true,
    this.writable = true,
  })  : uuid = uuid.toLowerCase(),
        id = IdGenerator().nextId() {
    _value = value;
  }

  void attachToCharacteristic(SimulatedCharacteristic characteristic) =>
      this.characteristic = characteristic;

  Future<Uint8List> read() async => _value;

  Future<void> write(Uint8List value) async {
    _value = value;
    if (_streamController?.hasListener == true) {
      _streamController.add(_value);
    }
  }

  Stream<Uint8List> monitor() {
    if (_streamController == null) {
      _streamController = StreamController.broadcast(
        onCancel: () {
          _streamController.close();
          _streamController = null;
        },
      );
    }
    return _streamController.stream;
  }
}
