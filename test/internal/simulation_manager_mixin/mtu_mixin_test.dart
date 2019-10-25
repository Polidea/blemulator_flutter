import 'package:blemulator/internal/internal.dart';
import 'package:test/test.dart';

import '../../factory/simulated_peripheral_factory.dart';
import '../../factory/simulation_manager_factory.dart';

void main() {
  const DEVICE_ID = "qwe123";
  const MTU = 13;
  PeripheralMtuMixin peripheralMtuMixin;

  setUp(() {
     peripheralMtuMixin = SimulationManagerFactory().create()
      ..addSimulatedPeripheral(
          (SimulatedPeripheralBuilder()
            ..isConnected = true
            ..mtu = MTU
            ..deviceId = DEVICE_ID)
          .build()
      );

  });

  test("should return MTU", () async {
    //when
    int mtu = await peripheralMtuMixin.requestMtuForDevice(DEVICE_ID);

    //then
    expect(mtu, MTU);
  });

  test("should change MTU", () async {
    //given
    const newMtu = 119;

    //when
    int mtu = await peripheralMtuMixin.requestMtuForDevice(DEVICE_ID, requestedMtu: newMtu);

    //then
    expect(mtu, newMtu);
  });
}