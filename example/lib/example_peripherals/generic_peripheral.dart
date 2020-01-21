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
                    convenienceName: 'Generic characteristic 1'),
              ],
              convenienceName: 'Generic service 1',
            ),
            SimulatedService(
              uuid: 'F000AA01-0001-4000-B000-000000000000',
              isAdvertised: true,
              characteristics: [
                SimulatedCharacteristic(
                    uuid: 'F000AA11-0001-4000-B000-000000000000',
                    value: Uint8List.fromList([0]),
                    convenienceName: 'Generic characteristic 2'),
              ],
              convenienceName: 'Generic service 2',
            ),
            SimulatedService(
              uuid: 'F000AA02-0001-4000-B000-000000000000',
              isAdvertised: true,
              characteristics: [
                SimulatedCharacteristic(
                    uuid: 'F000AA12-0001-4000-B000-000000000000',
                    value: Uint8List.fromList([0]),
                    convenienceName: 'Generic characteristic 3'),
              ],
              convenienceName: 'Generic service 3',
            ),
            SimulatedService(
              uuid: 'F000AA03-0001-4000-B000-000000000000',
              isAdvertised: true,
              characteristics: [
                SimulatedCharacteristic(
                    uuid: 'F000AA13-0001-4000-B000-000000000000',
                    value: Uint8List.fromList([0]),
                    convenienceName: 'Generic characteristic 4'),
              ],
              convenienceName: 'Generic service 4',
            ),
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
