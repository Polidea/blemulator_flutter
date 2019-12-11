import 'package:blemulator_example/common/components/title_icon.dart';
import 'package:blemulator_example/common/components/title_image_icon.dart';
import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:blemulator_example/util/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AssetManager {
  static Widget iconForPeripheral(BuildContext context,
      PeripheralCategory category) {
    Color color = ColorManager.colorForPeripheral(context, category);
    if (category == PeripheralCategory.sensorTag) {
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

  static Widget iconForSignalLevel(SignalLevel signalLevel) {
    return Icon(
      Icons.settings_input_antenna,
      color: ColorManager.colorForSignalLevel(signalLevel),
    );
  }
}
