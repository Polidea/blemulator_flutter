import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class CustomTextStyle {
  static const cardTitle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
  );

  static const cardValue = TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w600,
  );

  static const cardValueCompanion = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );

  static const cardValueAccessory = TextStyle(
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
    color: Colors.grey,
  );
}
