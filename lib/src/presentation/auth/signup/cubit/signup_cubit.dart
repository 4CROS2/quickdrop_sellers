import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/estableshment_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_auth_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/usecase/signup_usecase.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit({required SignupUsecase usecase})
      : _usecase = usecase,
        super(SignupState());

  final SignupUsecase _usecase;

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

  void setSellerData({
    required String name,
    required String lastName,
    required String documentType,
    required String id,
    required String date,
    required String phone,
  }) {
    emit(
      state.copyWith(
        sellerInformation: SellerInformationEntity(
          name: name,
          lastName: lastName,
          id: id,
          documentType: documentType,
          date: date,
          phone: phone,
        ),
      ),
    );
  }

  void setEstableshmentData({
    required String companyName,
    required String rut,
    required String description,
    required String contact,
    required String direction,
  }) {
    emit(
      state.copyWith(
        estableshmentInformation: EstableshmentInformationEntity(
          companyName: companyName,
          rut: rut,
          description: description,
          direction: direction,
          contact: contact,
        ),
      ),
    );
  }

  void _getLastPageData() {
    emit(
      state.copyWith(
        currentPage: state.currentPage + 1,
        signinState: SigninState.loading,
      ),
    );
  }

  Future<void> createNewAccount() async {
    _getLastPageData();
    try {
      await _usecase.createNewAccount(
        sellerAuth: state.sellerAuth,
        sellerInformation: state.sellerInformation,
        estableshmentInformation: state.estableshmentInformation,
      );
    } catch (e) {
      emit(
        state.copyWith(
            currentPage: state.currentPage - 1,
            errorMessage: e.toString(),
            signinState: SigninState.error),
      );
      emit(
        state.copyWith(
          signinState: SigninState.waiting,
        ),
      );
    }
  }

  void setPage(int value) {
    emit(
      state.copyWith(
        currentPage: value,
      ),
    );
  }
}
