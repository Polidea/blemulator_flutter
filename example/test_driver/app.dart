import 'package:blemulator/blemulator.dart';
import 'package:flutter_driver/driver_extension.dart';
import 'package:blemulator_example/main.dart' as app;


import 'peripherals.dart';



void main() {
  // This line enables the extension.
  enableFlutterDriverExtension();

  // Call the `main()` function of the app, or call `runApp` with
  // any widget you are interested in testing.
  app.main(peripherals: [basicSensorTag, advancedSensorTag]);
}