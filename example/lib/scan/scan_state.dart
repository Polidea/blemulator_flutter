import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ScanState extends Equatable {
  final List<ScanResultViewModel> scanResults;
  final bool scanningEnabled;

  const ScanState({@required this.scanResults, @required this.scanningEnabled});

  const ScanState.initial(
      {this.scanResults = const [], this.scanningEnabled = false});

  @override
  List<Object> get props => [scanResults, scanningEnabled];
}
