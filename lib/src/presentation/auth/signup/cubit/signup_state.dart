part of 'signup_cubit.dart';

enum SigninState { loading, error, success, waiting }

class SignupState extends Equatable {
  const SignupState({
    this.currentPage = 0,
    this.signinState = SigninState.waiting,
    this.companyName = '',
    this.ownerName = '',
    this.sellerAuth,
  });
  final int currentPage;
  final SellerAuthEntity? sellerAuth;
  final String ownerName;
  final String companyName;
  final SigninState signinState;

  SignupState copyWith({
    String? ownerName,
    String? companyName,
    SigninState? signinState,
    SellerAuthEntity? sellerAuth,
    int? currentPage,
  }) {
    return SignupState(
      currentPage: currentPage ?? this.currentPage,
      companyName: ownerName ?? this.companyName,
      ownerName: this.companyName,
      signinState: signinState ?? this.signinState,
      sellerAuth: sellerAuth ?? this.sellerAuth,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentPage,
        sellerAuth,
        ownerName,
        companyName,
        signinState,
      ];
  @override
  bool? get stringify => true;
}
