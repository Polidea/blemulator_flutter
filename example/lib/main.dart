import 'package:blemulator_example/device_details/device_detail_view.dart';
import 'package:blemulator_example/device_details/devices_details_bloc_provider.dart';
import 'package:blemulator_example/devices_list/devices_bloc_provider.dart';
import 'package:blemulator_example/devices_list/devices_list_view.dart';
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
  final bool useNewExample = true;

  @override
  Widget build(BuildContext context) {
    return useNewExample ? _buildNewExample() : _buildExample();
  }

  Widget _buildExample() {
    return MaterialApp(title: 'Blemulator example',
      theme: new ThemeData(
        primaryColor: new Color(0xFF0A3D91),
        accentColor: new Color(0xFFCC0000),
      ),
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (context) => DevicesBlocProvider(child: DevicesListScreen()),
        "/details": (context) =>
            DeviceDetailsBlocProvider(child: DeviceDetailsView()),
      },
      navigatorObservers: [routeObserver],
    );
  }

  Widget _buildNewExample() {
    return BlocProvider<NavigationBloc>(
      builder: (context) => NavigationBloc(navigatorKey: _navigatorKey),
      child: MaterialApp(
        navigatorKey: _navigatorKey,
        title: 'Blemulator example',
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
