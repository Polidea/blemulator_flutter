
import 'package:blemulator_example/device_details/device_details_bloc.dart';
import 'package:blemulator_example/device_details/view/button_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class TemperatureView extends StatelessWidget {

  final DeviceDetailsBloc _deviceDetailsBloc;

  TemperatureView(this._deviceDetailsBloc);

  void _connectAndMonitorTemperature() {
    _deviceDetailsBloc.connectAndMonitorTemperature();
  }

  void _disconnect() {
    _deviceDetailsBloc.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            StreamBuilder<PeripheralConnectionState>(
              stream: _deviceDetailsBloc.connectionState,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    snapshot.data.toString(),
                    style: TextStyle(fontSize: 16)
                  ),
                );
              }
            ),
            StreamBuilder<String>(
              stream: _deviceDetailsBloc.temperature,
              builder: (context, snapshot)
                => Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                      snapshot.data ?? "",
                      style: TextStyle(fontSize: 25)
                  ),
                ),
            ),
            Row(
              children: <Widget>[
                StreamBuilder<PeripheralConnectionState>(
                  stream: _deviceDetailsBloc.connectionState,
                  builder: (context, snapshot) {
                    if (snapshot.data == PeripheralConnectionState.connected) {
                      return ButtonView("Disconnnect", action: _disconnect);
                    } else {
                      return ButtonView("Connect", action: _connectAndMonitorTemperature);
                    }
                  }
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}