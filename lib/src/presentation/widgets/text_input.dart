import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';
import 'package:quickdrop_sellers/src/core/extensions/theme_extensions.dart';

class InputText extends StatefulWidget {
  const InputText({
    bool isPassword = false,
    bool isEnabled = true,
    TextInputType? textInputType,
    TextEditingController? controller,
    String? Function(String? value)? validator,
    Function(String value)? onChanged,
    String? labelText,
    List<TextInputFormatter>? formatters,
    super.key,
  })  : _onChanged = onChanged,
        _isPassword = isPassword,
        _controller = controller,
        _isEnabled = isEnabled,
        _hintText = labelText,
        _validator = validator,
        _formatters = formatters,
        _textInputType = textInputType;

  final TextEditingController? _controller;
  final TextInputType? _textInputType;
  final bool _isPassword;
  final bool _isEnabled;
  final String? _hintText;
  final String? Function(String? value)? _validator;
  final Function(String value)? _onChanged;
  final List<TextInputFormatter>? _formatters;

  @override
  State<InputText> createState() => _InputTextState();
}

class _InputTextState extends State<InputText> {
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
      inputFormatters: widget._formatters,
      decoration: InputDecoration(
        enabled: widget._isEnabled,
        labelText: widget._hintText?.capitalize(),
        labelStyle: TextStyle(
          fontWeight: FontWeight.w700,
          fontFamily: 'Questrial',
          color: context.textTheme.titleLarge!.color,
        ),
        suffixIcon: widget._isPassword
            ? InkWell(
                borderRadius: Constants.mainBorderRadius * 2,
                onTap: toggleShowText,
                child: AnimatedSwitcher(
                  duration: const Duration(
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
      style: const TextStyle(
        fontFamily: 'Questrial',
        fontWeight: FontWeight.w700,
      ),
      cursorOpacityAnimates: true,
      cursorRadius: Constants.mainBorderRadius.topRight,
    );
  }
}
