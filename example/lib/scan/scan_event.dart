import 'package:blemulator_example/scan/scan_result.dart';

abstract class ScanEvent {
  const ScanEvent();
}

class StartScan extends ScanEvent {}

class StopScan extends ScanEvent {}

class ScanResultsUpdated extends ScanEvent {
  final List<ScanResult> scanResults;

  const ScanResultsUpdated(this.scanResults);
}

class PickScanResult extends ScanEvent {
  final ScanResult scanResult;

  const PickScanResult(this.scanResult);
}