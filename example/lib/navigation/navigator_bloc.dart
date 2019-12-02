import 'dart:async';
import 'package:blemulator_example/navigation/route_name.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class NavigatorBloc extends Bloc<NavigationEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is NavigatorPop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToPeripheralDetails) {
      navigatorKey.currentState
          .pushNamed(RouteName.peripheralDetails, arguments: event.peripheral);
    }
  }
}
