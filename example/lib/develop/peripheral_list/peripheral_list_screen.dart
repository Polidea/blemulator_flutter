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
