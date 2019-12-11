import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:equatable/equatable.dart';

class PeripheralInfoViewModel extends Equatable {
  final String name;
  final String identifier;
  final PeripheralCategoryViewModel category;

  PeripheralInfoViewModel(this.name, this.identifier, this.category);

  @override
  List<Object> get props => [name, identifier, category];
}
