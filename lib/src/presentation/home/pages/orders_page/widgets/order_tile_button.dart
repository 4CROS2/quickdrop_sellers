import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class OrderTileButton extends StatelessWidget {
  const OrderTileButton({
    required this.label,
    this.elevation = 0,
    this.flex=1,
    this.surfaceTintColor,
    this.onTap,
    this.style,
    this.color,
    super.key,
  });
  final String label;
  final TextStyle? style;
  final Color? color;
  final Color? surfaceTintColor ;
  final VoidCallback? onTap;
  final double elevation;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex:flex ,
      child: Material(
        color: color,
        elevation: elevation,
        surfaceTintColor:surfaceTintColor,
        shadowColor: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        borderRadius: Constants.mainBorderRadius / 2,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: Constants.paddingValue * 1.2,
            ),
            child: Center(
              child: Text(
                label.capitalize(),
                style: style,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
