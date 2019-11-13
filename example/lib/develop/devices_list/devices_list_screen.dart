import 'package:blemulator_example/develop/devices_list/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DevicesListScreen extends StatelessWidget {
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
        child: BlocListener<DevicesListBloc, DevicesListState>(
          listener: (context, state) => _devicesListStateListener(context, state),
          child: BlocBuilder<DevicesListBloc, DevicesListState>(
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

  void _devicesListStateListener(BuildContext context, DevicesListState state) {
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
    final devicesListBloc = BlocProvider.of<DevicesListBloc>(context);
    devicesListBloc.add(StartScanning());
  }

  void _stopScanning(BuildContext context) {
    final devicesListBloc = BlocProvider.of<DevicesListBloc>(context);
    devicesListBloc.add(StopScanning());
  }
}
