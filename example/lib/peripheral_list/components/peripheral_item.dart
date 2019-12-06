import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:blemulator_example/util/ble_peripheral_category_stringifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralItem extends StatelessWidget {
  final BlePeripheral _peripheral;

  PeripheralItem(this._peripheral);

  @override
  Widget build(BuildContext context) {
    final navigatorBloc = BlocProvider.of<NavigationBloc>(context);

    return PropertyRow(
      title: BlePeripheralCategoryStringifier.name(_peripheral.category),
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
      ),
      onTap: () => _onRowTap(navigatorBloc),
    );
  }

  void _onRowTap(NavigationBloc navigatorBloc) {
    navigatorBloc.add(NavigateToPeripheralDetails(peripheral: _peripheral));
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
