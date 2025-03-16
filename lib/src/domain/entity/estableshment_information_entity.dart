class EstableshmentInformationEntity {
  const EstableshmentInformationEntity({
    required this.companyName,
    required this.rut,
    required this.description,
    required this.contact,
    required this.brand,
  });
  final String companyName;
  final String rut;
  final String description;
  final String contact;
  final String brand;

  const EstableshmentInformationEntity.empty()
      : companyName = '',
        contact = '',
        description = '',
        rut = '',
        brand = '';
}
