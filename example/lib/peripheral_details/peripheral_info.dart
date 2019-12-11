import 'package:blemulator_example/peripheral_details/peripheral_info_view_model.dart';
import 'package:blemulator_example/scan/scan_result.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:equatable/equatable.dart';

class PeripheralInfo extends Equatable {
  final String name;
  final String identifier;
  final PeripheralCategory category;

  PeripheralInfo(this.name, this.identifier, this.category);

  PeripheralInfoViewModel viewModel() {
    return PeripheralInfoViewModel(
      name,
      identifier,
      category,
      determinePeripheralLayout(category),
    );
  }

  @override
  List<Object> get props => [name, identifier, category];
}
