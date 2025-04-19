import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GoRouterBuilder extends StatefulWidget {
  const GoRouterBuilder({
    required this.builder,
    super.key,
    this.child,
  });

  final Widget Function(
    BuildContext context,
    GoRouterState state,
    Widget? child,
  ) builder;
  final Widget? child;

  @override
  State<GoRouterBuilder> createState() => _GoRouterBuilderState();
}

class _GoRouterBuilderState extends State<GoRouterBuilder>
    with WidgetsBindingObserver {
  late final GoRouter _router;
  late GoRouterState _state;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _router = GoRouter.of(context);
      _state = _router.state;
      _router.routerDelegate.addListener(_handleRouteChange);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Actualiza cuando la app vuelve al primer plano
    if (state == AppLifecycleState.resumed) {
      setState(() {
        _state = GoRouter.of(context).state;
      });
    }
    super.didChangeAppLifecycleState(state);
  }

  void _handleRouteChange() {
    final GoRouterState currentState = _router.state;
    if (_state.uri.path != currentState.uri.path) {
      setState(() {
        _state = currentState;
      });
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _router.routerDelegate.removeListener(_handleRouteChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el estado actual en cada build para capturar cambios inmediatos
    final GoRouterState currentState = GoRouter.of(context).state;
    return widget.builder(context, currentState, widget.child);
  }
}
