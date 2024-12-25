import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class ProductListBuilderHeader extends SliverPersistentHeaderDelegate {
  ProductListBuilderHeader({
    String label = '',
  }) : _label = label;

  final String _label;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Material(
      color: Colors.transparent,
      child: Text(
        _label.capitalize(),
        style: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  final double maxExtent = 50.0;

  @override
  final double minExtent = 50.0;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
