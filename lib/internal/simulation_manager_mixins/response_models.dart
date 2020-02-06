part of internal;

class CharacteristicResponse {
  SimulatedCharacteristic characteristic;
  Uint8List value;

  CharacteristicResponse(this.characteristic, this.value);
}

class DescriptorResponse {
  final SimulatedDescriptor descriptor;
  final Uint8List value;

  DescriptorResponse(this.descriptor, this.value);
}
