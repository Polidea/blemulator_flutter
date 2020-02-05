import 'package:blemulator_example/styles/custom_text_style.dart';
import 'package:flutter/material.dart';

class PropertyRow extends StatelessWidget {
  final String title;
  final String value;
  final Widget titleIcon;
  final Color titleColor;
  final String valueCompanion;
  final TextStyle valueTextStyle;
  final Widget rowAccessory;
  final Widget titleAccessory;
  final Widget valueAccessory;
  final GestureTapCallback onTap;

  PropertyRow({
    @required this.title,
    this.titleIcon,
    this.titleColor,
    @required this.value,
    this.valueTextStyle = CustomTextStyle.cardValue,
    this.valueCompanion,
    this.rowAccessory,
    this.titleAccessory,
    this.valueAccessory,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: _buildCardBody(),
          )),
    );
  }

  Widget _buildCardBody() {
    if (rowAccessory != null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: _buildMainColumn()),
          rowAccessory,
        ],
      );
    } else {
      return _buildMainColumn();
    }
  }

  Widget _buildMainColumn() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _buildTitleRow(),
        Padding(
          padding: const EdgeInsets.only(top: 14.0),
          child: _buildValueRow(),
        ),
      ],
    );
  }

  Widget _buildTitleRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        if (titleIcon != null)
          Padding(
            padding: const EdgeInsets.only(right: 4.0),
            child: titleIcon,
          ),
        Expanded(
          child: Text(
            title ?? '',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: CustomTextStyle.cardTitle.copyWith(
              color: titleColor,
            ),
          ),
        ),
        if (titleAccessory != null) titleAccessory,
      ],
    );
  }

  Widget _buildValueRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        _buildValue(),
        if (valueAccessory != null) valueAccessory,
      ],
    );
  }

  Widget _buildValue() {
    if (valueCompanion != null) {
      return Expanded(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: <Widget>[
            Flexible(
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.only(right: 4.0),
                child: Text(
                  value ?? '',
                  textWidthBasis: TextWidthBasis.longestLine,
                  style: valueTextStyle,
                ),
              ),
            ),
            Text(
              valueCompanion,
              style: CustomTextStyle.cardValueCompanion
                  .copyWith(color: Colors.grey),
            ),
          ],
        ),
      );
    } else {
      return Expanded(
        child: Text(
          value ?? '',
          style: valueTextStyle,
        ),
      );
    }
  }
}
