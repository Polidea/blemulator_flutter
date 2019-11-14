import 'package:flutter/material.dart';

class RssiView extends StatelessWidget {
  final String rssiValue;

  RssiView({this.rssiValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: Text(
        rssiValue,
        style: TextStyle(fontSize: 12),
      ),
    );
  }
}