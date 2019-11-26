import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/navigation/route_name.dart';
import 'package:blemulator_example/navigation/router.dart';
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
        initialRoute: RouteName.home,
        onGenerateRoute: (settings) => Router.generateRoute(settings),
      ),
    );
  }
}
