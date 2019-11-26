import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralDetailsScreen extends StatelessWidget {
  static const routeName = '/peripheralDetails';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PeripheralDetailsBloc, PeripheralDetailsState>(
      builder: (context, state) {
        if (state.peripheral.category == BlePeripheralCategory.sensorTag) {
          return DefaultTabController(
            length: 3,
            child: Scaffold(
              appBar: AppBar(
                title: Text(state.peripheral.name),
                bottom: TabBar(tabs: [
                  Tab(
                    icon: Icon(Icons.table_chart),
                    text: 'Details',
                  ),
                  Tab(
                    icon: Icon(Icons.format_list_numbered),
                    text: 'Auto test',
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: 'Manual test',
                  ),
                ]),
              ),
              body: TabBarView(
                children: <Widget>[
                  _buildDetailsView(),
                  Text('Auto test'),
                  Text('Manual test'),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(state.peripheral.name),
            ),
            body: _buildDetailsView(),
          );
        }
      },
    );
  }

  Widget _buildDetailsView() {
    return Text('Details');
  }
}
