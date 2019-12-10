import 'package:blemulator_example/scan/bloc.dart';
import 'package:blemulator_example/scan/components/scan_result_item.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scanBloc = BlocProvider.of<ScanBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth scanner'),
        actions: <Widget>[
          BlocBuilder<ScanBloc, ScanState>(
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
                    ? _stopScanning(scanBloc)
                    : _startScanning(scanBloc),
              );
            },
          )
        ],
      ),
      body: BlocBuilder<ScanBloc, ScanState>(
        condition: (previousState, state) {
          return previousState.scanResults != state.scanResults;
        },
        builder: (context, state) {
          List<ScanResultViewModel> scanResults = state.scanResults.values.toList();
          return ListView.builder(
            itemCount: scanResults.length,
            itemBuilder: (context, index) {
              return ScanResultItem(scanResults[index]);
            },
            padding: EdgeInsets.all(8.0),
          );
        },
      ),
    );
  }

  void _startScanning(ScanBloc peripheralListBloc) {
    peripheralListBloc.add(StartScan());
  }

  void _stopScanning(ScanBloc peripheralListBloc) {
    peripheralListBloc.add(StopScan());
  }
}
