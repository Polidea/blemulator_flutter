import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';

class RssiView extends StatelessWidget {
  final int _rssi;

  RssiView(this._rssi);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          _formatRssi(),
          style: CustomTextStyle.cardValueAccessory
              .copyWith(color: _signalLevel().color()),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Icon(
            Icons.settings_input_antenna,
            color: _signalLevel().color(),
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }

  String _formatRssi() {
    return '${_rssi ?? '-'} dbm';
  }

  SignalLevel _signalLevel() {
    if (_rssi == null) return SignalLevel.unknown;
    if (_rssi > -60) {
      return SignalLevel.high;
    } else if (_rssi > -90) {
      return SignalLevel.medium;
    } else {
      return SignalLevel.low;
    }
  }
}

enum SignalLevel { high, medium, low, unknown }

extension SignalLevelExtenstion on SignalLevel {
  Color color() {
    switch (this) {
      case SignalLevel.high:
        return Colors.green;
      case SignalLevel.medium:
        return Colors.orange;
      case SignalLevel.low:
        return Colors.red;
      case SignalLevel.unknown:
        return Colors.grey;
      default:
        return Colors.black;
    }
  }
}