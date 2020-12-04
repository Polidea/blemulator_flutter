part of blemulator;

class SimulatedService {
  final String uuid;
  final int id;
  final bool isAdvertised;
  final String convenienceName;
  final Map<int, SimulatedCharacteristic> _characteristics;

  SimulatedService(
      {@required String uuid,
      @required this.isAdvertised,
      @required List<SimulatedCharacteristic> characteristics,
      this.convenienceName})
      : uuid = uuid.toLowerCase(),
        _characteristics = Map.fromIterable(characteristics, key: (v) => v.id),
        id = IdGenerator().nextId() {
    _characteristics.values.forEach((v) => v.attachToService(this));
  }

  List<SimulatedCharacteristic> characteristics() =>
      _characteristics.values.toList();

  SimulatedCharacteristic characteristic(int id) => _characteristics[id];

  SimulatedCharacteristic characteristicByUuid(String uuid) =>
      _characteristics.values.firstWhere(
          (characteristic) =>
              characteristic.uuid.toLowerCase() == uuid.toLowerCase(),
          orElse: () => null);
}
