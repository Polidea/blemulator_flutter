import 'package:blemulator_example/common/components/title_icon.dart';
import 'package:blemulator_example/peripheral_details/bloc.dart';
import 'package:blemulator_example/common/components/property_row.dart';
import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PeripheralDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    PeripheralDetailsBloc peripheralDetailsBloc =
        BlocProvider.of<PeripheralDetailsBloc>(context);

    return CustomScrollView(
      slivers: <Widget>[
        SliverSafeArea(
          top: false,
          sliver: SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver:
                _buildPeripheralIdentifierRow(context, peripheralDetailsBloc),
          ),
        ),
      ],
    );
  }

  Widget _buildPeripheralIdentifierRow(
      BuildContext context, PeripheralDetailsBloc peripheralDetailsBloc) {
    return SliverToBoxAdapter(
      child: BlocBuilder<PeripheralDetailsBloc, PeripheralDetailsState>(
        builder: (context, state) {
          if (state is PeripheralAvailable) {
            return _buildPeripheralAvailableState(context, state);
          } else if (state is PeripheralUnavailable) {
            return _buildPeripheralUnavailableState(
                context, state, peripheralDetailsBloc);
          } else {
            return null;
          }
        },
      ),
    );
  }

  Widget _buildPeripheralAvailableState(
      BuildContext context, PeripheralAvailable state) {
    return PropertyRow(
      title: 'Identifier',
      titleIcon: TitleIcon(Icons.perm_device_information,
          color: Theme.of(context).primaryColor),
      titleColor: Theme.of(context).primaryColor,
      value: state.peripheralInfo.identifier,
    );
  }

  Widget _buildPeripheralUnavailableState(
      BuildContext context,
      PeripheralUnavailable state,
      PeripheralDetailsBloc peripheralDetailsBloc) {
    return PropertyRow(
      title: 'Identifier',
      titleIcon: TitleIcon(Icons.error, color: Theme.of(context).errorColor),
      titleColor: Theme.of(context).errorColor,
      value: state.identifier,
      titleAccessory: FlatButton(
        child: Text(
          'Refresh',
          style: CustomTextStyle.cartTitleAccessoryButton
              .copyWith(color: Colors.white),
        ),
        color: Theme.of(context).errorColor,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        onPressed: () => _onRefreshPeripheralTap(peripheralDetailsBloc),
      ),
    );
  }

  void _onRefreshPeripheralTap(PeripheralDetailsBloc peripheralDetailsBloc) {
    peripheralDetailsBloc.add(RefreshPeripheral());
  }
}
