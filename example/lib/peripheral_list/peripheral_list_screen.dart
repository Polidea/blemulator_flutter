import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/peripheral_list/bloc.dart';
import 'package:blemulator_example/peripheral_list/components/peripheral_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final peripheralListBloc = BlocProvider.of<PeripheralListBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth peripherals'),
        actions: <Widget>[
          BlocBuilder<PeripheralListBloc, PeripheralListState>(
            condition: (previousState, state) {
              return previousState.scanningEnabled != state.scanningEnabled;
            },
            builder: (context, state) {
              return IconButton(
                icon: Icon(state.scanningEnabled
                    ? Icons.bluetooth_searching
                    : Icons.bluetooth_disabled),
                tooltip: state.scanningEnabled
                    ? 'Disable Bluetooth scanning'
                    : 'Enable Bluetooth scanning',
                onPressed: () => state.scanningEnabled
                    ? _stopScanning(peripheralListBloc)
                    : _startScanning(peripheralListBloc),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<PeripheralListBloc, PeripheralListState>(
        condition: (previousState, state) {
          return previousState.peripherals != state.peripherals;
        },
        builder: (context, state) {
          List<BlePeripheral> peripherals = state.peripherals.values.toList();
          return ListView.builder(
            itemCount: peripherals.length,
            itemBuilder: (context, index) {
              return PeripheralItem(state.peripherals[index]);
            },
            padding: EdgeInsets.all(8.0),
          );
        },
      ),
    );
  }

  void _startScanning(PeripheralListBloc peripheralListBloc) {
    peripheralListBloc.add(StartPeripheralScan());
  }

  void _stopScanning(PeripheralListBloc peripheralListBloc) {
    peripheralListBloc.add(StopPeripheralScan());
  }
}
