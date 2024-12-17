import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/app_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/app_usecase.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit({
    required AppUsecase usecase,
  })  : _usecase = usecase,
        super(const AppState()) {
    _authCheckStatus();
  }
  final AppUsecase _usecase;
  StreamSubscription<AppEntity?>? _subscription;

  void _authCheckStatus() {
    _subscription = _usecase.authStatus().listen(
          (AppEntity? app) => _setAuthenticated(app: app),
          onError: _onError,
        );
  }

  void _setAuthenticated({required AppEntity? app}) {
    if (app != null) {
      emit(
        Authenticated(
          app: app,
        ),
      );
    } else {
      emit(
        UnAuthenticated(),
      );
    }
  }

  // ignore: always_specify_types
  void _onError(error) {
    emit(UnAuthenticated());
  }

  @override
  Future<void> close() {
    _subscription!.cancel();
    return super.close();
  }
}
