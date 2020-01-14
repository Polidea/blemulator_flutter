import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/peripheral_details/components/request_mtu_dialog.dart';
import 'package:fimber/fimber.dart';
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
              child: BlocListener<PeripheralDetailsBloc, PeripheralDetailsState>(
                listener: (context, state) {
                  if (state.mtuRequestState.showMtuDialog) {
                    showDialog<int>(
                        context: context,
                        builder: (BuildContext context) {
                          return RequestMtuDialog();
                        }
                    ).then((mtu) {
                      Fimber.d("Request MTU dialog result: $mtu");
                      BlocProvider.of<PeripheralDetailsBloc>(context).add(MtuRequestDismissed());
                      BlocProvider.of<PeripheralDetailsBloc>(context).add(RequestMtu(mtu));
                    });
                  }
                },
                child: BlocBuilder<PeripheralDetailsBloc, PeripheralDetailsState>(
                  builder: (context, state) {
                    Fimber.d("new state: $state");
                    return Column(
                      children: <Widget>[
                        PropertyRow(
                          title: 'Identifier',
                          titleIcon: Icon(Icons.perm_device_information),
                          titleColor: Theme.of(context).primaryColor,
                          value: state.peripheral.id,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Placeholder(fallbackHeight: 50),
                            ),
                            Expanded(
                              child: PropertyRow(
                                title: 'MTU',
                                titleColor: Theme.of(context).primaryColor,
                                value: "${state.peripheral.mtu}",
                                onTap: () { BlocProvider.of<PeripheralDetailsBloc>(context).add(StartMtuRequestProcess()); },
                                showIndicator: state.mtuRequestState.ongoingMtuRequest,
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
