import 'package:blemulator/blemulator.dart';

class GenericPeripheral extends SimulatedPeripheral {
  GenericPeripheral(
      {String name = 'Generic Peripheral',
      String id = 'generic-peripheral-id',
      int milliseconds = 1000,
      List<SimulatedService> services = const []})
      : super(
            name: name,
            id: id,
            advertisementInterval: Duration(milliseconds: milliseconds),
            services: services);
}
