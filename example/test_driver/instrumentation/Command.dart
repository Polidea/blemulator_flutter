
enum CommandType {
  ACTIVATE,
  DISCONNECT
}

class DeviceCommand {
  CommandType commandType;
  String deviceId;

  DeviceCommand(this.commandType, this.deviceId);

  DeviceCommand.fromMappedJson(Map<String, dynamic> json) {
    deviceId = json['deviceId'];
    var commandTypeName = json['commandType'];
    for (CommandType element in CommandType.values) {
      if (element.toString() == commandTypeName) {
        commandType = element;
      }
    }
  }

  Map<String, dynamic> toJson() =>
      {
        'commandType': commandType.toString(),
        'deviceId': deviceId,
      };
}