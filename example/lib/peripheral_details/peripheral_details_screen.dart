import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/components/peripheral_details_view.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final peripheralDetailsBloc = BlocProvider.of<PeripheralDetailsBloc>(context);

    if (peripheralDetailsBloc.state is PeripheralNotAvailable) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: Text('Peripheral not found'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },);
      });
    }

    return BlocBuilder<PeripheralDetailsBloc, PeripheralDetailsState>(
      builder: (context, state) {
        if (state is PeripheralAvailable) {
          if (state.peripheralInfo.category.peripheralLayout ==
              PeripheralLayout.tabbed) {
            return DefaultTabController(
              length: 3,
              child: Scaffold(
                appBar: AppBar(
                  title: _buildAppBarTitle(state.peripheralInfo.name),
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
                title: _buildAppBarTitle(state.peripheralInfo.name),
              ),
              body: _buildDetailsView(),
            );
          }
        } else {
          return Scaffold(
            appBar: AppBar(
              title: _buildAppBarTitle('Peripheral not found'),
            ),
            body: Container(
              color: Colors.white,
            ),
          );
        }
      },
    );
  }

  Widget _buildAppBarTitle(String name) {
    return Text(name);
  }

  Widget _buildDetailsView() {
    return PeripheralDetailsView();
  }
}
