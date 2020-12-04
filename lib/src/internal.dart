library internal;

import 'dart:async';
import 'dart:collection';
import 'dart:typed_data';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/services.dart';
import 'package:blemulator/blemulator.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart' as flutter_ble_lib;
import 'package:meta/meta.dart';

part 'bridge/constants.dart';

part 'bridge/dart_to_platform_bridge.dart';

part 'bridge/platform_to_dart_bridge.dart';

part 'defaults.dart';

part 'scan_result.dart';

part 'simulation_manager.dart';

part 'simulation_manager_mixins/characteristics_mixin.dart';

part 'simulation_manager_mixins/client_managing_mixin.dart';

part 'simulation_manager_mixins/descriptors_mixin.dart';

part 'simulation_manager_mixins/discovery_mixin.dart';

part 'simulation_manager_mixins/error_checks_mixin.dart';

part 'simulation_manager_mixins/peripheral_connection_mixin.dart';

part 'simulation_manager_mixins/peripheral_scanning_mixin.dart';

part 'simulation_manager_mixins/response_models.dart';

part 'simulation_manager_mixins/rssi_mixin.dart';

part 'simulation_manager_mixins/mtu_mixin.dart';

part 'simulation_manager_mixins/simulation_manager_base.dart';

part 'util/mappers.dart';
