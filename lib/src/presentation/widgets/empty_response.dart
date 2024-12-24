import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class EmptyResponse extends StatelessWidget {
  const EmptyResponse({
    required String label,
    super.key,
  }) : _label = label;
  final String _label;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: Constants.borderValue,
        children: <Widget>[
          Icon(
            Icons.inbox_rounded,
            size: 100,
          ),
          Text(
            _label.capitalize(),
          ),
        ],
      ),
    );
  }
}
