import 'package:blemulator_example/scan/scan_result.dart';
import 'package:equatable/equatable.dart';

class PeripheralDetails extends Equatable {
  final String name;
  final String identifier;
  final PeripheralCategory category;

  PeripheralDetails(this.name, this.identifier, this.category);

  @override
  List<Object> get props => [name, identifier, category];

}