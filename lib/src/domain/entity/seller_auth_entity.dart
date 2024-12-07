import 'package:equatable/equatable.dart';

class SellerAuthEntity extends Equatable {
  const SellerAuthEntity({
    this.email = '',
    this.password = '',
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

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => <Object?>[email, password];
}
