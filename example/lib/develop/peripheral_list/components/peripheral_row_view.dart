import 'dart:io';

import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/develop/peripheral_list/components/connection_state_view.dart';
import 'package:blemulator_example/develop/peripheral_list/components/rssi_view.dart';
import 'package:blemulator_example/develop/util/custom_colors.dart';
import 'package:flutter/material.dart';

class PeripheralRowView extends StatelessWidget {
  final BlePeripheral _peripheral;

  PeripheralRowView(this._peripheral);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: CustomColors.rowBackground,
          child: ListTile(
            leading: _buildListTileLeading(),
            title: Text(_peripheral.name),
            subtitle: Text(
              _peripheral.id,
              maxLines: 1,
            ),
            trailing: _buildListTileTrailing(),
            dense: true,
          ),
        ),
      ),
    );
  }

  Widget _buildListTileLeading() {
    return CircleAvatar(
      child: Icon(Icons.bluetooth),
    );
  }

  Widget _buildListTileTrailing() {
    return Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ConnectionStateView(
              isConnected: _peripheral.isConnected,
            ),
            SizedBox(height: 4.0),
            RssiView(
              rssiValue: _peripheral.rssiString,
            ),
          ],
        ),
        if (Platform.isIOS)
          Icon(Icons.chevron_right),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }
}
