import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quickdrop_sellers/src/domain/entity/estableshment_information_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_auth_entity.dart';
import 'package:quickdrop_sellers/src/domain/entity/seller_information_entity.dart';

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
}
