part of 'app_cubit.dart';

class AppState extends Equatable {
  const AppState();

  @override
  List<Object> get props => <Object>[];
}

class Authenticated extends AppState {
  const Authenticated({
    required this.user,
  });
  final User user;
}

class UnAuthenticated extends AppState {}
