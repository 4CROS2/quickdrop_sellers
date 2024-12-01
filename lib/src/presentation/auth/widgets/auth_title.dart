import 'package:extensions/extensions.dart';
import 'package:flutter/material.dart';

class AuthTitle extends StatelessWidget {
  const AuthTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Material(
        color: Colors.transparent,
        child: Hero(
          tag: 'title',
          transitionOnUserGestures: true,
          child: SizedBox(
            height: 130,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'QuickDrop',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Questrial',
                  ),
                ),
                Text(
                  'sellers'.capitalize(),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
