import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:quickdrop_sellers/src/routes/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AppRouter _appRouter;
  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
  }
  @override
  Widget build(BuildContext context) {

    /* return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Home(),
    ); */
    return MediaQuery(
      data: MediaQueryData.fromView(View.of(context)).copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: MaterialApp.router(
        title: 'Quickdrop Sellers',
        locale: Locale(
          View.of(context).platformDispatcher.locale.languageCode
        ),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        routerConfig: _appRouter.router,
      ),
    );
  }
}
