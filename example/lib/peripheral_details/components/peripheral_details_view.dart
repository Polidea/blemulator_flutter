import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
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
      BuildContext context, PeripheralDetailsState state) {
    final PeripheralDetailsBloc bloc = BlocProvider.of<PeripheralDetailsBloc>(context);

    return Flexible(
      fit: FlexFit.loose,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: state.bleServices.length,
        itemBuilder: (context, index) => InkWell(
          onTap: () => print("Clicked $index"), //TODO
          child: Row(
            children: <Widget>[
              Text("Id: ${state.bleServices[index].uuid}"),
            ],
          ),
        ),
      ),
    );
  }
}
