import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/presentation/home/pages/orders_page/widgets/order_header.dart';
import 'package:quickdrop_sellers/src/presentation/widgets/empty_response.dart';

class ProductListBuilder extends StatelessWidget {
  const ProductListBuilder({
    required String title,
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
        _title = title,
        _listEmptyMessage = listEmptyMessage,
        _refreshOnTap = refreshOnTap,
        _showRefreshButton = showRefreshButton;

  final int _itemCount;
  final String _listEmptyMessage;
  final String _title;
  final Widget? Function(BuildContext, int) _itemBuilder;
  final VoidCallback? _refreshOnTap;
  final bool _showRefreshButton;
  @override
  Widget build(BuildContext context) {
    if (_itemCount == 0) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          EmptyResponse(
            label: _listEmptyMessage.capitalize(),
          ),
          if (_showRefreshButton)
            ElevatedButton(
              onPressed: _refreshOnTap,
              child: Text(
                'refescar'.capitalize(),
              ),
            )
        ],
      );
    }
    return Padding(
      padding: Constants.mainPaddingWithOutBottom,
      child: CustomScrollView(
        physics: Constants.mainPhysics,
        slivers: <Widget>[
          SliverPersistentHeader(
            delegate: ProductListBuilderHeader(
              label: _title.capitalize(),
            ),
          ),
          SliverList.builder(
            itemCount: _itemCount,
            itemBuilder: _itemBuilder,
          )
        ],
      ),
    );
  }
}
