import 'dart:async';

import 'package:flutter/material.dart';

class GoListener extends ChangeNotifier {
  late final StreamSubscription<dynamic> _subscription;

  GoListener({required Stream<dynamic> stream}) {
    // Escucha el stream y notifica a GoRouter cuando hay cambios.
    _subscription = stream.asBroadcastStream().listen((_) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}