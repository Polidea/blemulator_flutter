import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/peripheral_details/components/characteristics_view.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details_bloc.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details_event.dart';
import 'package:blemulator_example/peripheral_details/peripheral_details_state.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServicesSliver extends StatelessWidget {
  final List<BleServiceState> _bleServiceStates;

  ServicesSliver(this._bleServiceStates);

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) =>
            _createServiceTileView(context, _bleServiceStates[index], index),
        childCount: _bleServiceStates.length,
      ),
    );
  }

  Widget _createServiceTileView(
    BuildContext context,
    BleServiceState serviceState,
    int index,
  ) {
    // ignore: close_sinks
    final bloc =
        BlocProvider.of<PeripheralDetailsBloc>(context);

    return Column(
      children: <Widget>[
        PropertyRow(
          title: 'Service UUID',
          titleColor: Theme.of(context).primaryColor,
          value: serviceState.service.uuid,
          valueTextStyle: CustomTextStyle.serviceUuidStyle,
          rowAccessory: IconButton(
            icon: Icon(
                serviceState.expanded ? Icons.unfold_less : Icons.unfold_more),
            onPressed: () => bloc.add(ServiceViewExpandedEvent(
              index,
            )),
          ),
        ),
        if (serviceState.expanded)
          Padding(
            padding: EdgeInsets.only(left: 16.0),
            child: ListView.builder(
              itemCount: serviceState.service.characteristics.length,
              itemBuilder: (context, index) => CharacteristicsView(
                  serviceState.service.characteristics[index]),
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
      ],
    );
  }
}
