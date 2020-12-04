/// Library with all BLEmulator definitions
///
/// To use create a Blemulator instance, add an instance of
/// SimulatedPeripheral to it and call blemulator.simulate()
library blemulator;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:blemulator/src/id_generator.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart' as flutter_ble_lib;

import 'src/internal.dart';

part 'simulated_ble_error.dart';

part 'blemulator_core.dart';

part 'simulation/simulated_characteristic.dart';

part 'simulation/simulated_descriptor.dart';

part 'simulation/simulated_peripheral.dart';

part 'simulation/simulated_service.dart';
