import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: <Widget>[
          Center(
            child: LottieBuilder.asset(
              'assets/lotties/wellcome/delivery.json',
            ),
          ),
          Center(
            child: Text('two'),
          )
        ],
      ),
    );
  }
}
