import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class RouteFactory {
  static MaterialPageRoute build<T extends Bloc<dynamic, dynamic>>(
      Bloc bloc,
      Widget view,
      ) {
    return MaterialPageRoute(
      builder: (_) => BlocProvider<T>(
        builder: (_) => bloc,
        child: view,
      ),
    );
  }
}