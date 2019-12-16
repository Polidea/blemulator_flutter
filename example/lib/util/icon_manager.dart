import 'package:blemulator_example/common/components/title_icon.dart';
import 'package:blemulator_example/common/components/title_image_icon.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IconManager {
  static Widget iconForPeripheral(
      BuildContext context, BlePeripheralCategory category) {
    Color color = Theme.of(context).primaryColor;
    if (category == BlePeripheralCategory.sensorTag) {
      return TitleImageIcon(
        AssetImage('assets/ti_logo.png'),
        color: color,
      );
    } else {
      return TitleIcon(
        Icons.bluetooth,
        color: color,
      );
    }
  }
}
