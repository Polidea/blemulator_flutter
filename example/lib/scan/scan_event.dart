import 'package:blemulator_example/scan/scan_result.dart';

abstract class ScanEvent {
  const ScanEvent();
}

class StartScan extends ScanEvent {}

class StopScan extends ScanEvent {}

class NewScanResult extends ScanEvent {
  final ScanResult scanResult;

  const NewScanResult(this.scanResult);
}

class PickScanResult extends ScanEvent {
  final ScanResult scanResult;

  const PickScanResult(this.scanResult);
}