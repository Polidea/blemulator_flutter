import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/util/peripheral_category_resolver.dart';

class SampleScanResult extends ScanResult {
  SampleScanResult(
      {String name = 'Sample peripheral name',
      String id = 'sample peripheral id',
      int rssi = -30,
      int mtu = 23,
      bool isConnectable = true})
      : super(
            name,
            id,
            PeripheralCategoryResolver.categoryForPeripheralName(name),
            rssi,
            mtu,
            isConnectable,
            null);

  SampleScanResult.different(
      {String name = 'Different peripheral name',
      String id = 'different peripheral id',
      int rssi = -30,
      int mtu = 23,
      bool isConnectable = true})
      : super(
            name,
            id,
            PeripheralCategoryResolver.categoryForPeripheralName(name),
            rssi,
            mtu,
            isConnectable,
            null);
}
