import 'package:flutter/material.dart';
import 'package:quickdrop_sellers/src/domain/repository/auth_repository.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final AuthRepository _repository;

  @override
  void initState() {
    super.initState();
    _repository = sl<AuthRepository>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _repository.destroySession();
        },
      ),
      body: Center(
        child: Text('hello word'),
      ),
    );
  }
}
