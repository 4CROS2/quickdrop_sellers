part of 'signup_cubit.dart';

enum SigninState { loading, error, success, waiting }

class SignupState extends Equatable {
  const SignupState({
    this.signinState = SigninState.waiting,
    this.currentPage = 0,
    this.sellerAuth = const SellerAuthEntity.empty(),
    this.sellerInformation = const SellerInformationEntity.empty(),
  });
  final SigninState signinState;
  final int currentPage;
  final SellerAuthEntity sellerAuth;
  final SellerInformationEntity sellerInformation;

  SignupState copyWith({
    SigninState? signinState,
    int? currentPage,
    SellerAuthEntity? sellerAuth,
    SellerInformationEntity? sellerInformation,
  }) {
    return SignupState(
      currentPage: currentPage ?? this.currentPage,
      signinState: signinState ?? this.signinState,
      sellerAuth: sellerAuth ?? this.sellerAuth,
      sellerInformation: sellerInformation ?? this.sellerInformation,
    );
  }

  @override
  List<Object?> get props =>
      <Object?>[currentPage, sellerAuth, signinState, sellerInformation];
  @override
  bool? get stringify => true;
}
