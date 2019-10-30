
import 'package:blemulator/blemulator.dart';

import 'test_simulated_peripheral.dart';

class UnconnectablePeripheral extends SimulatedPeripheral with TestCommandHandler implements CommandHandlerInterface {
  UnconnectablePeripheral(
      String id,
      { String name = "UnconnectableSensorTag",
        String localName = "UnconnectableSensorTag"})
      : super(
      name: name,
      id: id,
      advertisementInterval: Duration(milliseconds: 800),
      services: []
  ) {
    scanInfo.localName = localName;
  }

  @override
  Future<bool> onConnectRequest() {
    return Future.value(false);
  }


}