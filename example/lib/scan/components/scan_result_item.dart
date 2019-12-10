import 'package:blemulator_example/navigation/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/scan/scan_result_view_model.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ScanResultItem extends StatelessWidget {
  final ScanResultViewModel _scanResult;

  ScanResultItem(this._scanResult);

  @override
  Widget build(BuildContext context) {
    final navigationBloc = BlocProvider.of<NavigationBloc>(context);

    return PropertyRow(
      title: _scanResult.category.name,
      titleIcon: Icons.bluetooth,
      titleColor: Theme.of(context).primaryColor,
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
            style: CustomTextStyle.cardValueAccessory
                .copyWith(color: _rssiColor(_scanResult.rssi.signalLevel)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4.0),
            child: Icon(
              Icons.settings_input_antenna,
              color: _rssiColor(_scanResult.rssi.signalLevel),
            ),
          ),
        ],
        mainAxisSize: MainAxisSize.min,
      ),
      onTap: () => _onRowTap(navigationBloc),
    );
  }

  void _onRowTap(NavigationBloc navigationBloc) {
    navigationBloc.add(NavigateToPeripheralDetails(peripheralIdentifier: _scanResult.identifier));
  }

  Color _rssiColor(SignalLevel signalLevel) {
    switch (signalLevel) {
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
