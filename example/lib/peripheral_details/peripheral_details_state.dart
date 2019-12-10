import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class PeripheralDetailsState extends Equatable {

}

class PeripheralDetailsState extends Equatable {
  final String name;
  final String identifier;
  final PeripheralCategoryViewModel category;

  const PeripheralDetailsState({@required this.name, @required this.identifier, @required this.category});

  @override
  List<Object> get props => [name, identifier, category];
}
