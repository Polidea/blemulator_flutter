import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/components/services_sliver.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverPadding(
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
                  ],
                );
              },
            ),
          ),
        ),
        BlocBuilder<PeripheralDetailsBloc, PeripheralDetailsState>(
          builder: (context, state) {
            return ServicesSliver(state.bleServiceStates);
          },
        )
      ],
    );
  }
}
