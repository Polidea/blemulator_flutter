import 'package:blemulator/src/internal.dart';
import 'package:test/test.dart';

import '../../factory/simulated_peripheral_factory.dart';
import '../../factory/simulation_manager_factory.dart';

void main() {
  const DEVICE_ID = 'qwe123';
  const MTU = 33;
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

  test('should change MTU', () async {
    //given
    const newMtu = 119;

    //when
    var mtu = await peripheralMtuMixin.requestMtuForDevice(DEVICE_ID, newMtu);

    //then
    expect(mtu, newMtu);
  });

  test('should not allow to request MTU over 512', () async {
    //given
    const maxMtu = 512;

    //when
    var mtu = await peripheralMtuMixin.requestMtuForDevice(DEVICE_ID, maxMtu + 1);

    //then
    expect(mtu, maxMtu);
  });

  test('should not allow to request MTU below 23', () async {
    //given
    const minMtu = 23;

    //when
    var mtu = await peripheralMtuMixin.requestMtuForDevice(DEVICE_ID, minMtu - 23);

    //then
    expect(mtu, minMtu);
  });
}