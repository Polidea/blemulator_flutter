import 'package:flutter_driver/driver_extension.dart';
import 'package:blemulator_example/main.dart' as app;

import 'instrumentation/app_isolate/simulated_devices_adapter.dart';




void main() {

  SimulatedDevicesAdapter simulatedDevicesAdapter = SimulatedDevicesAdapter();

  enableFlutterDriverExtension(handler: simulatedDevicesAdapter.dataHandler);

  app.main(peripherals: simulatedDevicesAdapter.peripherals);
}