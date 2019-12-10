import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/navigation/route_name.dart';
import 'package:blemulator_example/navigation/router.dart';
import 'package:blemulator_example/styles/custom_colors.dart';
import 'package:blemulator_example/styles/custom_theme.dart';
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
    return BlocProvider<NavigationBloc>(
      builder: (context) => NavigationBloc(
          navigatorKey: _navigatorKey),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'FlutterBleLib example',
        theme: ThemeData(
          primaryColor: CustomColors.primary,
          accentColor: CustomColors.accent,
          scaffoldBackgroundColor: CustomColors.scaffoldBackground,
          cardTheme: CustomTheme.card,
        ),
        initialRoute: RouteName.home,
        onGenerateRoute: (settings) => Router.generateRoute(settings),
      ),
    );
  }
}
