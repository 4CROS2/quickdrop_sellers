import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class ProductListBuilder extends StatelessWidget {
  const ProductListBuilder({
    required String listEmptyMessage,
    required int itemCount,
    required Widget Function(
      BuildContext context,
      int index,
    ) itemBuilder,
    VoidCallback? refreshOnTap,
    bool showRefreshButton = false,
    super.key,
  })  : _itemCount = itemCount,
        _itemBuilder = itemBuilder,
        _listEmptyMessage = listEmptyMessage,
        _refreshOnTap = refreshOnTap,
        _showRefreshButton = showRefreshButton;

  final int _itemCount;
  final String _listEmptyMessage;

  final Widget? Function(BuildContext context, int index) _itemBuilder;
  final VoidCallback? _refreshOnTap;
  final bool _showRefreshButton;
  @override
  Widget build(BuildContext context) {
    if (_itemCount == 0) {
      return SliverFillRemaining(
        child: Material(
          type: MaterialType.card,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Icon(
                  HugeIcons.strokeRoundedDeliveryBox02,
                  size: 100,
                ),
                Text(
                  _listEmptyMessage.capitalize(),
                ),
                if (_showRefreshButton)
                  ElevatedButton(
                    onPressed: _refreshOnTap,
                    child: Text(
                      'refescar'.capitalize(),
                    ),
                  )
              ],
            ),
          ),
        ),
      );
    }
    return SliverPadding(
      padding: Constants.mainPadding,
      sliver: SliverList.builder(
        itemCount: _itemCount,
        itemBuilder: _itemBuilder,
      ),
    );
  }
}
