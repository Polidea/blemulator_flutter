import 'package:blemulator_example/scan/scan_result.dart';
import 'package:equatable/equatable.dart';

class PeripheralInfoViewModel extends Equatable {
  final String name;
  final String identifier;
  final PeripheralCategory category;
  final PeripheralLayout peripheralLayout;

  PeripheralInfoViewModel(
      this.name, this.identifier, this.category, this.peripheralLayout);

  @override
  List<Object> get props => [name, identifier, category];
}

PeripheralLayout determinePeripheralLayout(PeripheralCategory category) {
  if (category == PeripheralCategory.sensorTag) {
    return PeripheralLayout.tabbed;
  } else {
    return PeripheralLayout.simple;
  }
}

enum PeripheralLayout { simple, tabbed }