import 'package:blemulator_example/peripheral_details/components/peripheral_auto_test_view.dart';
import 'package:blemulator_example/peripheral_details/components/peripheral_details_view.dart';
import 'package:blemulator_example/peripheral_details/components/peripheral_manual_test_view.dart';
import 'package:flutter/material.dart';

class PeripheralDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Perpipheral details'),
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
            PeripheralDetailsView(),
            PeripheralAutoTestView(),
            PeripheralManualTestView(),
          ],
        ),
      ),
    );
  }
}
