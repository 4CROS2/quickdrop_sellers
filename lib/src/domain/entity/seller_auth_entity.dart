import 'package:equatable/equatable.dart';

class SellerAuthEntity extends Equatable {
  const SellerAuthEntity({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  SellerAuthEntity copyWith({
    String? email,
    String? password,
  }) {
    return SellerAuthEntity(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  const SellerAuthEntity.empty()
      : email = '',
        password = '';

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => <Object?>[email, password];
}
