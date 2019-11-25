import 'package:flutter/material.dart';

class PropertyRow extends StatelessWidget {
  final IconData titleIcon;
  final String title;
  final Color titleColor;
  final String value;
  final String valueCompanion;
  final Widget accessory;

  PropertyRow({
    this.titleIcon,
    this.title,
    this.titleColor,
    this.value = '',
    this.valueCompanion,
    this.accessory,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
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
                        style: TextStyle(
                          color: titleColor,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                  ],
                ),
                SizedBox(
                  height: 16.0,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: <Widget>[
                    if (value != null)
                      Text(
                        value,
                        style: TextStyle(
                          fontSize: 26.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    if (value != null && valueCompanion != null)
                      SizedBox(
                        width: 2.0,
                      ),
                    if (valueCompanion != null)
                      Text(
                        valueCompanion,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
          if (accessory != null) accessory,
        ],
      ),
    );
  }
}
