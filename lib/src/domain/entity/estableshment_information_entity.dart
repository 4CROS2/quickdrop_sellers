class EstableshmentInformationEntity {
  const EstableshmentInformationEntity({
    required this.companyName,
    required this.rut,
    required this.description,
    required this.direction,
    required this.contact,
  });
  final String companyName;
  final String rut;
  final String description;
  final String direction;
  final String contact;

  const EstableshmentInformationEntity.empty()
      : companyName = '',
        contact = '',
        description = '',
        direction = '',
        rut = '';
}