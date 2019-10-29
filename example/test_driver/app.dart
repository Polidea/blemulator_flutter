import 'package:blemulator/blemulator.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:blemulator_example/main.dart' as app;

import 'advance_sensor_tag.dart';
import 'basic_sensor_tag.dart';
import 'peripherals.dart';



void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  print('peripheral1----------------------${peripheral1}');
  Communicator.register(() => peripheral1.onDisconnect());
  app.main(peripherals: [peripheral1, AdvanceSensorTag()]);
}