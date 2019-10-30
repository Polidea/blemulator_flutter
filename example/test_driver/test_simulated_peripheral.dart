import 'package:flutter/foundation.dart';

import 'package:blemulator/blemulator.dart';

import 'Command.dart';


mixin TestCommandHandler on SimulatedPeripheral {

  void handleDeviceCommand(DeviceCommand deviceCommand) {
    switch (deviceCommand.commandType) {
      case CommandType.DISCONNECT:
        onDisconnect();
        break;
      default:
        break;
    }
  }
}

abstract class CommandHandlerInterface {
  void handleDeviceCommand(DeviceCommand deviceCommand);
}