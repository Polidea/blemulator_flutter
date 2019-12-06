import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/peripheral_details/components/property_row.dart';
import 'package:flutter/material.dart';
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
                  return PropertyRow(
                    title: 'Identifier',
                    titleIcon: Icons.perm_device_information,
                    titleColor: Theme.of(context).primaryColor,
                    value: state.peripheral.id,
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
