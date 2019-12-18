import 'dart:typed_data';

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
          services: [
            SimulatedService(
                uuid: 'F000AA00-0001-4000-B000-000000000000',
                isAdvertised: true,
                characteristics: [
                  SimulatedCharacteristic(
                      uuid: 'F000AA10-0001-4000-B000-000000000000',
                      value: Uint8List.fromList([0]),
                      convenienceName: 'Generic characteristic'),
                ],
                convenienceName: 'Generic service'),
          ],
        );

  @override
  Future<bool> onConnectRequest() async {
    await Future.delayed(Duration(milliseconds: 500));
    return super.onConnectRequest();
  }

  @override
  Future<void> onDiscoveryRequest() async {
    await Future.delayed(Duration(milliseconds: 1000));
    return super.onDiscoveryRequest();
  }
}
