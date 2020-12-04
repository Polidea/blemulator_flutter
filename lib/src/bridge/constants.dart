part of internal;

abstract class ChannelName {
  static const String _base = 'com.polidea.blemulator';
  static const String platformToDart = '$_base/toDart';
  static const String dartToPlatform = '$_base/toJava';
}

abstract class PlatformMethodName {
  static const String simulate = 'simulate';
}

abstract class SimulationPlatformMethodName {
  static const String publishScanResult = 'publishScanResult';
  static const String publishConnectionState = 'publishConnectionState';
  static const String publishCharacteristicUpdate =
      'publishCharacteristicUpdate';
  static const String publishCharacteristicMonitoringError =
      'publishCharacteristicMonitoringError';
}

abstract class DartMethodName {
  static const String createClient = 'createClient';
  static const String destroyClient = 'destroyClient';

  static const String startDeviceScan = 'startDeviceScan';
  static const String stopDeviceScan = 'stopDeviceScan';

  static const String connectToPeripheral = 'connectToDevice';
  static const String isPeripheralConnected = 'isDeviceConnected';
  static const String disconnectOrCancelConnectionToPeripheral =
      'disconnectOrCancelConnection';

  static const String discoverAllServicesAndCharacteristics =
      'discoverAllServicesAndCharacteristics';

  static const String readCharacteristicForIdentifier =
      'readCharacteristicForIdentifier';
  static const String readCharacteristicForDevice =
      'readCharacteristicForDevice';
  static const String readCharacteristicForService =
      'readCharacteristicForService';

  static const String writeCharacteristicForIdentifier =
      'writeCharacteristicForIdentifier';
  static const String writeCharacteristicForDevice =
      'writeCharacteristicForDevice';
  static const String writeCharacteristicForService =
      'writeCharacteristicForService';

  static const String monitorCharacteristicForIdentifier =
      'monitorCharacteristicForIdentifier';
  static const String monitorCharacteristicForDevice =
      'monitorCharacteristicForDevice';
  static const String monitorCharacteristicForService =
      'monitorCharacteristicForService';

  static const String writeDescriptorForIdentifier =
      'writeDescriptorForIdentifier';
  static const String writeDescriptorForCharacteristic =
      'writeDescriptorForCharacteristic';
  static const String writeDescriptorForService = 'writeDescriptorForService';
  static const String writeDescriptorForDevice = 'writeDescriptorForDevice';

  static const String readDescriptorForIdentifier =
      'readDescriptorForIdentifier';
  static const String readDescriptorForCharacteristic =
      'readDescriptorForCharacteristic';
  static const String readDescriptorForService = 'readDescriptorForService';
  static const String readDescriptorForDevice = 'readDescriptorForDevice';

  static const String cancelTransaction = 'cancelTransaction';
  static const String readRssi = 'rssi';
  static const String requestMtu = 'requestMtu';
}

abstract class SimulationArgumentName {
  static const String deviceIdentifier = 'deviceIdentifier';
  static const String serviceUuid = 'serviceUuid';
  static const String serviceId = 'serviceId';
  static const String characteristicUuid = 'characteristicUuid';
  static const String characteristicIdentifier = 'characteristicIdentifier';
  static const String descriptorId = 'descriptorIdentifier';
  static const String descriptorUuid = 'descriptorUuid';
  static const String name = 'name';
  static const String id = 'id';
  static const String mtu = 'mtu';
  static const String rssi = 'rssi';
  static const String isConnectable = 'isConnectable';
  static const String txPowerLevel = 'txPowerLevel';
  static const String manufacturerData = 'manufacturerData';
  static const String serviceData = 'serviceData';
  static const String serviceUuids = 'serviceUuids';
  static const String localName = 'localName';
  static const String solicitedServiceUuids = 'solicitedServiceUuids';
  static const String overflowUuids = 'overflowUuids';
  static const String value = 'value';

  static const String connectionState = 'connectionState';

  static const String characteristics = 'characteristics';
  static const String uuid = 'uuid';
  static const String transactionId = 'transactionId';
}

abstract class Metadata {
  static const String deviceIdentifier = 'deviceIdentifier';

  static const String serviceId = 'serviceId';
  static const String serviceUuid = 'serviceUuid';
  static const String characteristicUuid = 'characteristicUuid';
  static const String characteristicId = 'characteristicId';
  static const String isReadable = 'isReadable';
  static const String isWritableWithResponse = 'isWritableWithResponse';
  static const String isWritableWithoutResponse = 'isWritableWithoutResponse';
  static const String isNotifiable = 'isNotifiable';
  static const String isNotifying = 'isNotifying';
  static const String isIndicatable = 'isIndicatable';
  static const String value = 'value';
  static const String descriptors = 'descriptors';
  static const String descriptorId = 'descriptorId';
  static const String descriptorUuid = 'descriptorUuid';

  static const String errorCode = 'errorCode';
  static const String reason = 'reason';
  static const String transactionId = 'transactionId';
}

abstract class ArgumentName {
  static const String id = 'id';
  static const String serviceUuid = 'serviceUuid';
}

abstract class NativeConnectionState {
  static const String connecting = 'CONNECTING';
  static const String connected = 'CONNECTED';
  static const String disconnecting = 'DISCONNECTING';
  static const String disconnected = 'DISCONNECTED';
}
