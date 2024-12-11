/// Represents the information of a seller.
class SellerInformationEntity {
  const SellerInformationEntity({
    required this.name,
    required this.lastName,
    required this.id,
    required this.documentType,
    required this.date,
    required this.phone,
  });

  /// The seller's first name.
  final String name;

  /// The seller's last name.
  final String lastName;

  /// The seller's identification number.
  final String id;

  /// The type of document the seller uses for identification.
  final String documentType;

  /// The date of registration for the seller.
  final String date;

  /// The seller's phone number.
  final String phone;

  /// Creates an empty instance of [SellerInformationEntity].
  const SellerInformationEntity.empty()
      : name = '',
        lastName = '',
        id = '',
        documentType = '',
        date = '',
        phone = '';
}
