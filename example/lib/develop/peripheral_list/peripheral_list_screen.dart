import 'package:blemulator_example/develop/peripheral_list/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _buildTestLayout(context);
  }

  Widget _buildTestLayout(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Screen'),
      ),
      body: Container(
        child: BlocListener<PeripheralListBloc, PeripheralListState>(
          listener: (context, state) => _peripheralListStateListener(context, state),
          child: BlocBuilder<PeripheralListBloc, PeripheralListState>(
              builder: (context, state) {
            return Row(
              children: <Widget>[
                RaisedButton(
                  child: Text('Start scanning'),
                  onPressed: () => _startScanning(context),
                ),
                RaisedButton(
                  child: Text('Stop scanning'),
                  onPressed: () => _stopScanning(context),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  void _peripheralListStateListener(BuildContext context, PeripheralListState state) {
    if (state is ScanningStarted) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Scanning started'),
        ),
      );
    } else if (state is ScanningStopped) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Scanning stopped'),
        ),
      );
    }
  }

  void _startScanning(BuildContext context) {
    final peripheralListBloc = BlocProvider.of<PeripheralListBloc>(context);
    peripheralListBloc.add(StartScanning());
  }

  void _stopScanning(BuildContext context) {
    final peripheralListBloc = BlocProvider.of<PeripheralListBloc>(context);
    peripheralListBloc.add(StopScanning());
  }
}
