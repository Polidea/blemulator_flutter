import 'package:blemulator_example/develop/peripheral_list/bloc.dart';
import 'package:blemulator_example/develop/peripheral_list/components/peripheral_row_view.dart';
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
              return PeripheralRowView(state.peripherals[index]);
            },
            padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
          );
        }),
      ),
      backgroundColor: CustomColors.systemGroupedBackground,
    );
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
