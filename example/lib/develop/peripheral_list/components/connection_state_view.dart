import 'package:flutter/material.dart';

class ConnectionStateView extends StatelessWidget {
  final bool isConnected;

  ConnectionStateView({this.isConnected = false});

  @override
  Widget build(BuildContext context) {
    return Icon(
      isConnected ? Icons.bluetooth_connected : Icons.bluetooth,
      color: isConnected ? Colors.green : Colors.red,
    );
  }
}