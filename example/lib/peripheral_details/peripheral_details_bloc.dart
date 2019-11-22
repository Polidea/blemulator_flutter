import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PeripheralDetailsBloc extends Bloc<PeripheralDetailsEvent, PeripheralDetailsState> {
  @override
  PeripheralDetailsState get initialState => InitialPeripheralDetailsState();

  @override
  Stream<PeripheralDetailsState> mapEventToState(
    PeripheralDetailsEvent event,
  ) async* {
  }
}
