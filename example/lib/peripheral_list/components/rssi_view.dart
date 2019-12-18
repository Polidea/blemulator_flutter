import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:blemulator_example/util/signal_level.dart';
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
              .copyWith(color: signalLevelForRssi(_rssi).color()),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0),
          child: Icon(
            Icons.settings_input_antenna,
            color: signalLevelForRssi(_rssi).color(),
          ),
        ),
      ],
      mainAxisSize: MainAxisSize.min,
    );
  }

  String _formatRssi() {
    return '${_rssi ?? '-'} dbm';
  }
}