import 'package:flutter/material.dart';

abstract class CustomTheme {
  static const card = CardTheme(
    elevation: 0,
    shape: RoundedRectangleBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(8.0),
      ),
    ),
  );
}