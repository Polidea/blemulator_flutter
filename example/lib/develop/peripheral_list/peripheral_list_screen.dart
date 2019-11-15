import 'dart:io';

import 'package:blemulator_example/develop/model/ble_peripheral.dart';
import 'package:blemulator_example/develop/peripheral_list/bloc.dart';
import 'package:blemulator_example/develop/peripheral_list/components/connection_state_view.dart';
import 'package:blemulator_example/develop/peripheral_list/components/rssi_view.dart';
import 'package:blemulator_example/develop/util/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth peripherals'),
        actions: <Widget>[
          BlocBuilder<PeripheralListBloc, PeripheralListState>(
            condition: (previousState, state) {
              return previousState.scanningEnabled != state.scanningEnabled;
            },
            builder: (context, state) {
              if (state.scanningEnabled) {
                return IconButton(
                  icon: Icon(Icons.bluetooth_disabled),
                  tooltip: 'Disable Bluettoh scanning',
                  onPressed: () => _stopScanning(context),
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.bluetooth_searching),
                  tooltip: 'Enable Bluettoh scanning',
                  onPressed: () => _startScanning(context),
                );
              }
            },
          )
        ],
      ),
      body: Container(
        child: BlocBuilder<PeripheralListBloc, PeripheralListState>(
            builder: (context, state) {
          return ListView.builder(
            itemCount: state.peripherals.length,
            itemBuilder: (context, index) {
              return _buildRow(context, state.peripherals[index]);
            },
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          );
        }),
      ),
      backgroundColor: CustomColors.systemGroupedBackground,
    );
  }

  static Widget _buildRow(BuildContext context, BlePeripheral peripheral) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 8.0, 0, 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Container(
          color: CustomColors.rowBackground,
          child: ListTile(
            leading: _buildListTileLeading(),
            title: Text(peripheral.name),
            subtitle: Text(
              peripheral.id,
              maxLines: 1,
            ),
            trailing: _buildListTileTrailing(peripheral),
            dense: true,
          ),
        ),
      ),
    );
  }

  static Widget _buildListTileLeading() {
    return CircleAvatar(
      child: Icon(Icons.bluetooth),
    );
  }

  static Widget _buildListTileTrailing(BlePeripheral peripheral) {
    if (Platform.isIOS) {
      return Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConnectionStateView(
                isConnected: peripheral.isConnected,
              ),
              SizedBox(height: 4.0),
              RssiView(
                rssiValue: peripheral.rssiString,
              ),
            ],
          ),
          Icon(Icons.chevron_right),
        ],
        mainAxisSize: MainAxisSize.min,
      );
    } else {
      return Row(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ConnectionStateView(
                isConnected: peripheral.isConnected,
              ),
              SizedBox(height: 4.0),
              RssiView(
                rssiValue: peripheral.rssiString,
              ),
            ],
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      );
    }
  }

  void _startScanning(BuildContext context) {
    final peripheralListBloc = BlocProvider.of<PeripheralListBloc>(context);
    peripheralListBloc.add(StartPeripheralScan());
  }

  void _stopScanning(BuildContext context) {
    final peripheralListBloc = BlocProvider.of<PeripheralListBloc>(context);
    peripheralListBloc.add(StopPeripheralScan());
  }
}
