import 'package:blemulator_example/model/ble_service.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: BlocBuilder<PeripheralDetailsBloc, PeripheralDetailsState>(
                builder: (context, state) {
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      PropertyRow(
                        title: 'Identifier',
                        titleIcon: Icon(Icons.perm_device_information),
                        titleColor: Theme.of(context).primaryColor,
                        value: state.peripheral.id,
                      ),
                      _createServiceView(context, state)
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _createServiceView(
    BuildContext context,
    PeripheralDetailsState state,
  ) {
    return Flexible(
      fit: FlexFit.loose,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.bleServiceStates.length,
        itemBuilder: (context, index) =>
            _createServiceTileView(context, state.bleServiceStates[index]),
      ),
    );
  }

  Widget _createServiceTileView(
    BuildContext context,
    BleServiceState serviceState,
  ) {
    // ignore: close_sinks
    final PeripheralDetailsBloc bloc =
        BlocProvider.of<PeripheralDetailsBloc>(context);

    return PropertyRow(
      title: "Service UUID",
      titleColor: Theme.of(context).primaryColor,
      value: serviceState.service.uuid,
      valueTextStyle: CustomTextStyle.serviceUuidStyle,
      rowAccessory: IconButton(
        icon: Icon(serviceState.expanded ? Icons.unfold_less : Icons.unfold_more),
        onPressed: () => bloc.add(ServiceViewExpandedEvent(
          serviceState,
          !serviceState.expanded,
        )),
      ),
    );
  }
}
