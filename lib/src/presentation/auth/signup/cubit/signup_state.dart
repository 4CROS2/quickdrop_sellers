part of 'signup_cubit.dart';

enum SigninState { loading, error, waiting }

class SignupState extends Equatable {
  const SignupState({
    this.signinState = SigninState.waiting,
    this.currentPage = 0,
    this.sellerAuth = const SellerAuthEntity.empty(),
    this.location = EstablishmentLocationEntity.empty,
    this.sellerInformation = const SellerInformationEntity.empty(),
    this.estableshmentInformation =
        const EstableshmentInformationEntity.empty(),
    this.errorMessage = '',
  });
  final SigninState signinState;
  final int currentPage;
  final SellerAuthEntity sellerAuth;
  final EstablishmentLocationEntity location;
  final SellerInformationEntity sellerInformation;
  final EstableshmentInformationEntity estableshmentInformation;
  final String errorMessage;

  SignupState copyWith({
    SigninState? signinState,
    int? currentPage,
    SellerAuthEntity? sellerAuth,
    EstablishmentLocationEntity? location,
    SellerInformationEntity? sellerInformation,
    EstableshmentInformationEntity? estableshmentInformation,
    String? errorMessage,
  }) {
    return SignupState(
      currentPage: currentPage ?? this.currentPage,
      signinState: signinState ?? this.signinState,
      sellerAuth: sellerAuth ?? this.sellerAuth,
      location: location ?? this.location,
      sellerInformation: sellerInformation ?? this.sellerInformation,
      errorMessage: errorMessage ?? this.errorMessage,
      estableshmentInformation:
          estableshmentInformation ?? this.estableshmentInformation,
    );
  }

  @override
  List<Object?> get props => <Object?>[
        currentPage,
        errorMessage,
        signinState,
        sellerAuth,
        location,
        sellerInformation,
        estableshmentInformation,
      ];
  @override
  bool? get stringify => true;
}
