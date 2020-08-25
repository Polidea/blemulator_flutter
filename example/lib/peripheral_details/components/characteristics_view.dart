import 'package:blemulator_example/model/ble_service.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CharacteristicsView extends StatelessWidget {
  final BleCharacteristic _characteristic;

  CharacteristicsView(this._characteristic);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'UUID: ${_characteristic.uuid}',
              style: CustomTextStyle.characteristicsStyle,
            ),
            Text(
              'Properties: ${_getCharacteristicProperties(_characteristic).toString()}',
              style: CustomTextStyle.characteristicsStyle,
            ),
          ],
        ),
      ),
    );
  }

  static List<String> _getCharacteristicProperties(
      BleCharacteristic characteristic) {
    var properties = <String>[];

    if (characteristic.isWritableWithResponse ||
        characteristic.isWritableWithoutResponse) {
      properties.add('write');
    }
    if (characteristic.isReadable) {
      properties.add('read');
    }
    if (characteristic.isIndicatable || characteristic.isNotifiable) {
      properties.add('notify');
    }

    return properties;
  }
}
