import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_auth_entity.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit() : super(SignupState());

  void setPage(int value) {
    emit(
      state.copyWith(
        currentPage: value,
      ),
    );
  }

  void setAuthData({
    required String email,
    required String password,
  }) {
    emit(
      state.copyWith(
        sellerAuth: SellerAuthEntity(
          email: email,
          password: password,
        ),
      ),
    );
  }

  void setSellerData() {}
}
