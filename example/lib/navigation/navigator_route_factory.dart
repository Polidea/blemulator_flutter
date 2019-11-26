import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatorRouteFactory {
  static MaterialPageRoute build<T extends Bloc<dynamic, dynamic>>(
      BuildContext context,
      Bloc bloc,
      Widget view,
      ) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider<T>(
        builder: (context) => bloc,
        child: view,
      ),
    );
  }
}