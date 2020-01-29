import 'package:blemulator_example/styles/custom_sizes.dart';
import 'package:flutter/widgets.dart';

class TitleImageIcon extends ImageIcon {
  TitleImageIcon(ImageProvider image, {Color color})
      : super(image, size: CustomSizes.titleIcon, color: color);
}
