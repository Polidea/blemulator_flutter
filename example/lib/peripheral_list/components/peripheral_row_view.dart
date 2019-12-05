import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralRowView extends StatelessWidget {
  final BlePeripheral _peripheral;

  PeripheralRowView(this._peripheral);

  @override
  Widget build(BuildContext context) {
    final navigatorBloc = BlocProvider.of<NavigationBloc>(context);

    return PropertyRow(
      title: 'Category',
      titleIcon: Icons.bluetooth,
      titleColor: Theme.of(context).primaryColor,
      value: _peripheral.name,
      titleAccessory: _buildTitleAccessory(),
      valueAccessory: _buildValueAccessory(),
      onTap: () => _onRowTap(navigatorBloc),
    );
  }

  void _onRowTap(NavigationBloc navigatorBloc) {
    navigatorBloc.add(NavigateToPeripheralDetails(peripheral: _peripheral));
  }

  Widget _buildTitleAccessory() {
    return Icon(
      Icons.chevron_right,
      color: Colors.grey,
    );
  }

  Widget _buildValueAccessory() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          '${_peripheral.rssi ?? '-'} dbm',
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
    );
  }

  Color _colorForRssi(int rssi) {
    if (rssi == null) return Colors.red;

    if (rssi > -60) {
      return Colors.green;
    } else if (rssi > -90) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }
}
