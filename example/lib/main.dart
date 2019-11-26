import 'package:blemulator_example/di/ble_adapter_injector.dart';
import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/navigation/navigator_route_factory.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details_screen.dart';
import 'package:blemulator_example/peripheral_list/bloc.dart';
import 'package:blemulator_example/peripheral_list/peripheral_list_screen.dart';
import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Fimber.plantTree(DebugTree());
  runApp(MyApp());
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavigatorBloc>(
      builder: (context) => NavigatorBloc(navigatorKey: _navigatorKey),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'FlutterBleLib example',
        theme: new ThemeData(
          primaryColor: new Color(0xFF0A3D91),
          accentColor: new Color(0xFFCC0000),
        ),
        initialRoute: PeripheralListScreen.routeName,
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case PeripheralListScreen.routeName:
              return NavigatorRouteFactory.build<PeripheralListBloc>(
                context,
                PeripheralListBloc(BleAdapterInjector.inject),
                PeripheralListScreen(),
              );
            case PeripheralDetailsScreen.routeName:
              return NavigatorRouteFactory.build<PeripheralDetailsBloc>(
                context,
                PeripheralDetailsBloc(
                    BleAdapterInjector.inject, settings.arguments),
                PeripheralDetailsScreen(),
              );
            default:
              return NavigatorRouteFactory.build<PeripheralListBloc>(
                context,
                PeripheralListBloc(BleAdapterInjector.inject),
                PeripheralListScreen(),
              );
          }
        },
      ),
    );
  }
}
