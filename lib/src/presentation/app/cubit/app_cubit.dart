import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState()) {
    authTest();
  }

  void authTest() {
    Future<void>.delayed(
      Duration(milliseconds: 1500),
      () {
        emit(UnAuthenticated());
      },
    );
  }
}
