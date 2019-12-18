import 'package:blemulator_example/common/components/title_icon.dart';
import 'package:blemulator_example/common/components/title_image_icon.dart';
import 'package:blemulator_example/model/ble_peripheral.dart';
import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/peripheral_list/components/rssi_view.dart';
import 'package:blemulator_example/styles/custom_colors.dart';
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
      titleIcon: _iconForPeripheral(context),
      titleColor: _peripheral.category.color(context),
      value: _peripheral.name,
      titleAccessory: Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      valueAccessory: RssiView(_peripheral.rssi),
      onTap: () => _onRowTap(navigationBloc),
    );
  }

  void _onRowTap(NavigationBloc navigationBloc) {
    navigationBloc.add(NavigateToPeripheralDetails(peripheral: _peripheral));
  }

  Widget _iconForPeripheral(BuildContext context) {
    if (_peripheral.category == BlePeripheralCategory.sensorTag) {
      return TitleImageIcon(
        AssetImage('assets/ti_logo.png'),
        color: CustomColors.sensorTagRed,
      );
    } else {
      return TitleIcon(
        Icons.bluetooth,
        color: Theme.of(context).primaryColor,
      );
    }
  }
}
