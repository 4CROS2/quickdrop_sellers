import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/usecase/login_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required LoginUsecase usecase})
      : _usecase = usecase,
        super(const LoginState());
  final LoginUsecase _usecase;

  void login({
    required String email,
    required String password,
  }) async {
    try {
      emit(Loading());
      await _usecase.loginWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      emit(
        Error(
          message: e.code,
        ),
      );
    }
  }
}
