import 'dart:io';

import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralRowView extends StatelessWidget {
  final BlePeripheral _peripheral;

  PeripheralRowView(this._peripheral);

  @override
  Widget build(BuildContext context) {
    final navigatorBloc = BlocProvider.of<NavigationBloc>(context);

    return PropertyRow(
      title: 'Category',
      titleIcon: Icons.bluetooth,
      titleColor: Theme.of(context).primaryColor,
      value: _peripheral.name,
      rowAccessory: _buildAccessory(),
      onTap: () => _onRowTap(navigatorBloc),
    );
  }

  void _onRowTap(NavigationBloc navigatorBloc) {
    navigatorBloc.add(NavigateToPeripheralDetails(peripheral: _peripheral));
  }

  Widget _buildAccessory() {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.signal_cellular_4_bar,
              color: _colorForRssi(_peripheral.rssi),
            ),
            SizedBox(height: 4.0),
            Text(
              '${_peripheral.rssi ?? '-'} dbm',
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
        // Apply design guidelines properly for both platforms:
        // iOS - list rows with disclosure indicator
        // Android - list rows without disclosure indicator
        if (Platform.isIOS)
          Icon(Icons.chevron_right),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }

  Color _colorForRssi(int rssi) {
    if (rssi > -60) {
      return Colors.blue;
    } else if (rssi > -90) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
