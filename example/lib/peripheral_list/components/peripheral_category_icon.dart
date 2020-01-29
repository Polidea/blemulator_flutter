import 'package:blemulator_example/common/components/title_icon.dart';
import 'package:blemulator_example/common/components/title_image_icon.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/styles/custom_colors.dart';
import 'package:flutter/material.dart';

class PeripheralCategoryIcon extends StatelessWidget {
  final BlePeripheralCategory _peripheralCategory;

  PeripheralCategoryIcon(this._peripheralCategory);

  @override
  Widget build(BuildContext context) {
    if (_peripheralCategory == BlePeripheralCategory.sensorTag) {
      return TitleImageIcon(
        AssetImage('assets/ti_logo.png'),
        color: CustomColors.sensorTagRed,
      );
    } else {
      return TitleIcon(
        Icons.bluetooth,
        color: Theme.of(context).primaryColor,
      );
    }
  }
}
