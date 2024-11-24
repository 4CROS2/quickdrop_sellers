import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  void login({
    required String email,
    required String password,
  }) {
    try {
      emit(Loading());
      throw Exception('$email/$password');
    } catch (e) {
      emit(
        Error(
          message: e.toString(),
        ),
      );
    }
  }
}
