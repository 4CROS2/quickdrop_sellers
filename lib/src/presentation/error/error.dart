import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:quickdrop_sellers/src/core/constants/constants.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({
    required String path,
    super.key,
  }) : _path = path;
  final String _path;
  void _pop(BuildContext context) {
    if (context.canPop()) {
      context.pop();
      return;
    } else {
      context.go('/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => _pop(context),
        ),
        title: Text(
          'not found'.capitalize(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: Constants.paddingValue,
          children: <Widget>[
            Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.grey,
              size: 90,
              grade: 2,
              weight: 1,
            ),
            Text('la pagina $_path no fue  encontrada'.capitalizeSentences()),
            TextButton.icon(
              onPressed: () => _pop(context),
              icon: Icon(Icons.home_rounded),
              label: Text(
                'home'.capitalize(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
