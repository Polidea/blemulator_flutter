import 'dart:async';
import 'package:blemulator_example/adapter/ble_adapter.dart';
import 'package:blemulator_example/navigation/route_name.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, void> {
  final GlobalKey<NavigatorState> navigatorKey;
  BleAdapter bleAdapter;

  NavigationBloc({@required this.navigatorKey, @required this.bleAdapter});

  @override
  void get initialState {
    return;
  }

  @override
  Stream<dynamic> mapEventToState(
    NavigationEvent event,
  ) async* {
    if (event is Pop) {
      navigatorKey.currentState.pop();
    } else if (event is NavigateToPeripheralDetails) {
      _navigateToPeripheralDetails(event);
    }
  }

  void _navigateToPeripheralDetails(NavigateToPeripheralDetails event) {
    navigatorKey.currentState.pushNamed(RouteName.peripheralDetails,
        arguments: bleAdapter
            .peripheralDetailsForIdentifier(event.peripheralIdentifier));
  }
}
