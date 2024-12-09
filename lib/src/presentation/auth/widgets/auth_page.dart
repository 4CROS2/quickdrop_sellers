import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({
    String label = '',
    GlobalKey<FormState>? formKey,
    List<Widget> children = const <Widget>[],
    super.key,
  })  : _label = label,
        _children = children,
        _formKey = formKey;
  final String _label;
  final List<Widget> _children;
  final GlobalKey<FormState>? _formKey;

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage>
    with AutomaticKeepAliveClientMixin {
  late final ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return SingleChildScrollView(
      padding: Constants.authInputPadding,
      controller: _controller,
      child: Column(
        children: <Widget>[
          Form(
            key: widget._formKey,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(
                    top: 30,
                  ),
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      widget._label.capitalize(),
                      softWrap: true,
                      style: TextStyle(
                        fontFamily: 'Questrial',
                        fontSize: 43,
                        fontWeight: FontWeight.w900,
                        height: .85,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30 + Constants.paddingValue,
                ),
                ...widget._children
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
