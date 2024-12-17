import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class InformationTile extends StatelessWidget {
  const InformationTile({
    String label = '',
    String description = '',
    VoidCallback? onTap,
    IconData icon = Icons.access_alarm,
    bool alert = false,
    super.key,
  })  : _label = label,
        _description = description,
        _onTap = onTap,
        _icon = icon,
        _badgeVisible = alert;

  final String _label;
  final String _description;
  final IconData _icon;
  final VoidCallback? _onTap;
  final bool? _badgeVisible;

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Constants.mainBorderRadius,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: EdgeInsets.all(
            Constants.paddingValue / 2,
          ),
          child: Column(
            children: <Widget>[
              Row(
                spacing: Constants.paddingValue,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _InformationTileIcon(
                    icon: _icon,
                    isVisible: _badgeVisible,
                  ),
                  _InformationTitleAndDescription(
                    label: _label,
                    description: _description,
                  ),
                  Icon(Icons.arrow_forward_ios_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InformationTitleAndDescription extends StatelessWidget {
  const _InformationTitleAndDescription({
    String label = '',
    String description = '',
  })  : _label = label,
        _description = description;

  final String _label;
  final String _description;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      fit: FlexFit.tight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: Constants.paddingValue * .3,
        children: <Widget>[
          Text(
            _label.capitalize(),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          if (_description.isNotEmpty)
            Text(
              _description.capitalize(),
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
        ],
      ),
    );
  }
}

class _InformationTileIcon extends StatelessWidget {
  const _InformationTileIcon({
    required IconData icon,
    bool? isVisible = false,
  })  : _isVisible = isVisible,
        _icon = icon;

  final bool? _isVisible;
  final IconData _icon;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Constants.secondaryColor.withValues(
        alpha: .2,
      ),
      borderRadius: Constants.mainBorderRadius / 2,
      child: Badge(
        isLabelVisible: _isVisible!,
        label: Icon(
          Icons.error,
          color: Constants.secondaryColor,
          size: 15,
        ),
        backgroundColor: Colors.transparent,
        child: Padding(
          padding: EdgeInsets.all(
            Constants.paddingValue * 1.2,
          ),
          child: Icon(
            _icon,
          ),
        ),
      ),
    );
  }
}
