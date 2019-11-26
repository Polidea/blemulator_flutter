import 'package:blemulator_example/di/ble_adapter_injector.dart';
import 'package:blemulator_example/navigation/route_factory.dart' as Navigation;
import 'package:blemulator_example/navigation/route_name.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details_screen.dart';
import 'package:blemulator_example/peripheral_list/bloc.dart';
import 'package:blemulator_example/peripheral_list/peripheral_list_screen.dart';
import 'package:flutter/material.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return Navigation.RouteFactory.build<PeripheralListBloc>(
          PeripheralListBloc(BleAdapterInjector.inject),
          PeripheralListScreen(),
        );
      case RouteName.peripheralDetails:
        return Navigation.RouteFactory.build<PeripheralDetailsBloc>(
          PeripheralDetailsBloc(
              BleAdapterInjector.inject, settings.arguments),
          PeripheralDetailsScreen(),
        );
      default:
        return Navigation.RouteFactory.build<PeripheralListBloc>(
          PeripheralListBloc(BleAdapterInjector.inject),
          PeripheralListScreen(),
        );
    }
  }
}