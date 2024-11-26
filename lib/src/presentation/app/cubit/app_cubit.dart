import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  StreamSubscription<User?>? _subscription;

  void _authCheckStatus() {
    _subscription = _usecase.authStatus().listen(
          (User? user) => _setAuthenticated(user: user),
          onError: _onError,
        );
  }

  void _setAuthenticated({required User? user}) {
    if (user != null) {
      emit(
        Authenticated(
          user: user,
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
