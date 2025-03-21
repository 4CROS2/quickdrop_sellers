import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/core/localization/app_localizations.dart';
import 'package:quickdrop_sellers/src/core/themes/theme.dart';
import 'package:quickdrop_sellers/src/injection/injection_barrel.dart';

import 'package:quickdrop_sellers/src/presentation/app/cubit/app_cubit.dart';
import 'package:quickdrop_sellers/src/presentation/notifications/cubit/notifications_cubit.dart';
import 'package:quickdrop_sellers/src/routes/routes.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  late final AppRouter _appRouter;
  bool _isDark = false;
  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeDependencies() {
    _initializeTheme(
      context,
    );
    super.didChangeDependencies();
  }

  @override
  void didChangePlatformBrightness() {
    _initializeTheme(context);
    setState(() {});
    super.didChangePlatformBrightness();
  }

  void _initializeTheme(BuildContext context) {
    _isDark = View.of(context).platformDispatcher.platformBrightness ==
        Brightness.dark;
    AppTheme.initialize(
      context,
      isDarkMode: _isDark,
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaler: const TextScaler.linear(1.0),
      ),
      child: MultiBlocProvider(
        providers: <BlocProvider<Object?>>[
          BlocProvider<AppCubit>(
            create: (BuildContext context) => sl<AppCubit>(),
          ),
          BlocProvider<NotificationsCubit>(
            create: (BuildContext context) {
              final NotificationsCubit notificationsCubit =
                  sl<NotificationsCubit>();
              if (FirebaseAuth.instance.currentUser != null) {
                notificationsCubit.initializeNotifications();
              }
              return notificationsCubit;
            },
            lazy: false,
          ),
        ],
        child: BlocBuilder<AppCubit, AppState>(
          builder: (BuildContext context, AppState state) {
            return MaterialApp.router(
              title: 'Quickdrop Sellers',
              locale: Locale(
                View.of(context).platformDispatcher.locale.languageCode,
              ),
              theme: AppTheme.instance,
              supportedLocales: AppLocalizations.supportedLocales,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              routerConfig: _appRouter.router,
            );
          },
        ),
      ),
    );
  }
}
