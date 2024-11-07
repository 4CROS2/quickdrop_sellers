import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickdrop_sellers/src/injection/injection_container.dart' as di;
import 'package:quickdrop_sellers/src/presentation/app/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();

  await SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) {
    runApp(const App());
  });
}
