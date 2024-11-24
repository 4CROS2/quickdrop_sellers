import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/extensions/string_extensions.dart';

class AuthInput extends StatefulWidget {
  const AuthInput({
    bool isPassword = false,
    bool isEnabled = true,
    TextEditingController? controller,
    String? hintText,
    super.key,
  })  : _isPassword = isPassword,
        _controller = controller,
        _isEnabled = isEnabled,
        _hintText = hintText;

  final TextEditingController? _controller;
  final bool _isPassword;
  final bool _isEnabled;
  final String? _hintText;

  @override
  State<AuthInput> createState() => _AuthInputState();
}

class _AuthInputState extends State<AuthInput> {
  bool _showText = true;
  void toggleShowText() {
    setState(
      () => _showText = !_showText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget._controller,
      enabled: widget._isEnabled,
      obscureText: widget._isPassword && _showText,
      decoration: InputDecoration(
        enabled: widget._isEnabled,
        hintText: widget._hintText?.capitalize(),
        suffixIcon: widget._isPassword
            ? InkWell(
                borderRadius: Constants.mainBorderRadius * 2,
                onTap: toggleShowText,
                child: AnimatedSwitcher(
                  duration: Duration(
                    milliseconds: 200,
                  ),
                  child: Icon(
                    key: Key(
                      _showText.toString(),
                    ),
                    _showText
                        ? Icons.remove_red_eye_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              )
            : null,
      ),
      cursorOpacityAnimates: true,
      cursorRadius: Constants.mainBorderRadius.topRight,
    );
  }
}
