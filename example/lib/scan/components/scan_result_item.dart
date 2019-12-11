import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:blemulator_example/util/asset_manager.dart';
import 'package:blemulator_example/util/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanResultItem extends StatelessWidget {
  final ScanResultViewModel _scanResult;

  ScanResultItem(this._scanResult);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return PropertyRow(
      title: _scanResult.identifier,
      titleIcon: AssetManager.iconForPeripheral(context, _scanResult.category),
      titleColor: ColorManager.colorForPeripheral(context, _scanResult.category),
      value: _scanResult.name,
      titleAccessory: Icon(
        Icons.chevron_right,
        color: Colors.grey,
      ),
      valueAccessory: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            _scanResult.rssi.value,
            style: CustomTextStyle.cardValueAccessory.copyWith(
                color: ColorManager.colorForSignalLevel(
                    _scanResult.rssi.signalLevel)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child:
                AssetManager.iconForSignalLevel(_scanResult.rssi.signalLevel),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      onTap: () => _onRowTap(navigationBloc, context),
    );
  }

  void _onRowTap(NavigationBloc navigationBloc, BuildContext context) {
    navigationBloc.add(NavigateToPeripheralDetails(
        peripheralIdentifier: _scanResult.identifier));
  }
}
