import 'package:equatable/equatable.dart';

class BlePeripheral extends Equatable {
  String name;
  String id;
  int rssi;
  bool isConnected;

  BlePeripheral(this.name, this.id, this.rssi, this.isConnected);

  @override
  List<Object> get props => [name, id];
}