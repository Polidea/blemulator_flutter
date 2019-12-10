import 'package:blemulator_example/peripheral_details/peripheral_details.dart';
import 'package:blemulator_example/util/peripheral_category_resolver.dart';

class SamplePeripheralDetails extends PeripheralDetails {
  SamplePeripheralDetails(
      {String name = 'Sample peripheral name',
        String id = 'sample peripheral id'})
      : super(
      name,
      id,
      PeripheralCategoryResolver.categoryForPeripheralName(name),);

  SamplePeripheralDetails.different(
      {String name = 'Different peripheral name',
        String id = 'different peripheral id'})
      : super(
      name,
      id,
      PeripheralCategoryResolver.categoryForPeripheralName(name),);
}
