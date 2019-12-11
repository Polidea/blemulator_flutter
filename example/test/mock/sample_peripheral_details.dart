import 'package:blemulator_example/peripheral_details/peripheral_info.dart';
import 'package:blemulator_example/util/peripheral_category_resolver.dart';

class SamplePeripheralInfo extends PeripheralInfo {
  SamplePeripheralInfo(
      {String name = 'Sample peripheral name',
        String id = 'sample peripheral id'})
      : super(
      name,
      id,
      PeripheralCategoryResolver.categoryForPeripheralName(name),);

  SamplePeripheralInfo.different(
      {String name = 'Different peripheral name',
        String id = 'different peripheral id'})
      : super(
      name,
      id,
      PeripheralCategoryResolver.categoryForPeripheralName(name),);
}
