import 'package:equatable/equatable.dart';

class BlePeripheral extends Equatable {
  final String name;
  final String id;
  final int rssi;
  final bool isConnected;

  BlePeripheral(this.name, this.id, this.rssi, this.isConnected);

  @override
  List<Object> get props => [name, id];
}