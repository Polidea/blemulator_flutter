import 'dart:async';
import 'package:blemulator_example/peripheral_details/peripheral_details_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(
    NavigatorEvent event,
  ) async* {
    if (event is NavigatorPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToPeripheralDetails) {
      navigatorKey.currentState
          .pushNamed(PeripheralDetailsScreen.routeName, arguments: event.peripheral);
    }
  }
}
