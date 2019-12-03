import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';

enum PropertyRowAccessoryPosition {
  titleRow,
  valueRow,
  full,
}

class PropertyRow extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final Color titleColor;
  final String value;
  final String valueCompanion;
  final Widget accessory;
  final PropertyRowAccessoryPosition accessoryPosition;

  PropertyRow({
    this.titleIcon,
    this.title,
    this.titleColor,
    this.value = '',
    this.valueCompanion,
    this.accessory,
    this.accessoryPosition = PropertyRowAccessoryPosition.full,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: _buildCardBody(),
    );
  }

  Widget _buildCardBody() {
    switch (accessoryPosition) {
      case PropertyRowAccessoryPosition.titleRow:
      case PropertyRowAccessoryPosition.valueRow:
        {
          return _buildMainColumn();
        }
      case PropertyRowAccessoryPosition.full:
      default:
        {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildMainColumn(),
              _buildAccessory(),
            ],
          );
        }
    }
  }

  Widget _buildMainColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitleRow(),
        SizedBox(height: 16.0),
        _buildValueRow(),
      ],
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0, top: 12.0, right: 12.0),
          child: Row(
            children: <Widget>[
              if (titleIcon != null)
                Icon(
                  titleIcon,
                  color: titleColor,
                  size: 20.0,
                ),
              if (titleIcon != null && title != null)
                SizedBox(
                  width: 4.0,
                ),
              if (title != null)
                Text(
                  title,
                  style: CustomTextStyle.cardTitle.copyWith(
                    color: titleColor,
                  ),
                ),
            ],
          ),
        ),
        if (accessoryPosition == PropertyRowAccessoryPosition.titleRow &&
            accessory != null)
          _buildAccessory(),
      ],
    );
  }

  Widget _buildValueRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: <Widget>[
              if (value != null)
                Text(
                  value,
                  style: CustomTextStyle.cardValue,
                ),
              if (value != null && valueCompanion != null)
                SizedBox(
                  width: 2.0,
                ),
              if (valueCompanion != null)
                Text(
                  valueCompanion,
                  style: CustomTextStyle.cardValueCompanion
                      .copyWith(color: Colors.grey),
                ),
            ],
          ),
        ),
        if (accessoryPosition == PropertyRowAccessoryPosition.valueRow &&
            accessory != null)
          _buildAccessory(),
      ],
    );
  }

  Widget _buildAccessory() {
    return Padding(
      padding: _accessoryEdgeInsets(),
      child: accessory,
    );
  }

  EdgeInsetsGeometry _accessoryEdgeInsets() {
    switch (accessoryPosition) {
      case PropertyRowAccessoryPosition.titleRow:
        {
          return EdgeInsets.only(top: 8.0, right: 8.0);
        }
      case PropertyRowAccessoryPosition.valueRow:
        {
          return EdgeInsets.only(right: 8.0, bottom: 8.0);
        }
      case PropertyRowAccessoryPosition.full:
      default:
        {
          return EdgeInsets.only(top: 8.0, right: 8.0, bottom: 8.0);
        }
    }
  }
}
