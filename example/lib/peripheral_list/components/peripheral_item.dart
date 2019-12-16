import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:blemulator_example/util/signal_level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralItem extends StatelessWidget {
  final BlePeripheral _peripheral;

  PeripheralItem(this._peripheral);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return PropertyRow(
      title: _peripheral.id,
      titleIcon: Icons.bluetooth,
      titleColor: Theme.of(context).primaryColor,
      value: _peripheral.name,
      titleAccessory: Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      valueAccessory: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            _formatRssi(_peripheral.rssi),
            style: CustomTextStyle.cardValueAccessory
                .copyWith(color: _colorForRssi(_peripheral.rssi)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(
              Icons.settings_input_antenna,
              color: _colorForRssi(_peripheral.rssi),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      onTap: () => _onRowTap(navigationBloc),
    );
  }

  void _onRowTap(NavigationBloc navigationBloc) {
    navigationBloc.add(NavigateToPeripheralDetails(peripheral: _peripheral));
  }
  
  String _formatRssi(int rssi) {
    return '${rssi ?? '-'} dbm';
  }

  Color _colorForRssi(int rssi) {
    if (rssi == null) return Colors.grey;

    switch (parseRssi(rssi)) {
      case SignalLevel.high:
        return Colors.green;
      case SignalLevel.medium:
        return Colors.orange;
      case SignalLevel.low:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
