import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class TextInput extends StatefulWidget {
  const TextInput({
    bool isPassword = false,
    bool isEnabled = true,
    TextInputType? textInputType,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    String? labelText,
    super.key,
  })  : _onChanged = onChanged,
        _isPassword = isPassword,
        _controller = controller,
        _isEnabled = isEnabled,
        _hintText = labelText,
        _validator = validator,
        _textInputType = textInputType;

  final TextEditingController? _controller;
  final TextInputType? _textInputType;
  final bool _isPassword;
  final bool _isEnabled;
  final String? _hintText;
  final String? Function(String?)? _validator;
  final Function(String)? _onChanged;

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  bool _showText = true;
  void toggleShowText() {
    setState(
      () => _showText = !_showText,
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget._controller,
      enabled: widget._isEnabled,
      onChanged: widget._onChanged,
      obscureText: widget._isPassword && _showText,
      validator: widget._validator,
      keyboardType: widget._textInputType,
      decoration: InputDecoration(
        enabled: widget._isEnabled,
        labelText: widget._hintText?.capitalize(),
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
