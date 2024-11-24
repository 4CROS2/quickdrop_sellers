part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => <Object>[];
}

class Loading extends LoginState {}

class Error extends LoginState {
  const Error({required this.message});
  final String message;
}

class Success extends LoginState {}
