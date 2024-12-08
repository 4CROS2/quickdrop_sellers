import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class SignupButton extends StatelessWidget {
  const SignupButton({
    String label = '',
    VoidCallback? onTap,
    IconData? prefixIcon,
    IconData? suffixIcon,
    super.key,
  })  : _onTap = onTap,
        _label = label,
        _prefixIcon = prefixIcon,
        _suffixIcon = suffixIcon;

  final String? _label;
  final VoidCallback? _onTap;
  final IconData? _prefixIcon;
  final IconData? _suffixIcon;
  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: Constants.mainBorderRadius,
      clipBehavior: Clip.hardEdge,
      color: Constants.secondaryColor,
      child: InkWell(
        onTap: _onTap,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Constants.paddingValue * 2,
            vertical: Constants.paddingValue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if (_prefixIcon != null) _iconButton(icon: _prefixIcon),
              Text(
                _label!.capitalize(),
                style:
                    TextStyle(fontWeight: FontWeight.w700, color: Colors.white),
              ),
              if (_suffixIcon != null) _iconButton(icon: _suffixIcon),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton({
    required IconData icon,
  }) {
    return Icon(
      icon,
      size: 16,
      color: Colors.white,
    );
  }
}
