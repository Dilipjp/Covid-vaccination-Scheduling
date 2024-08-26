class VaccinationCenter {
  final String name;
  final String address;

  VaccinationCenter({
    required this.name,
    required this.address,
  });

  factory VaccinationCenter.fromMap(Map<String, dynamic> map) {
    return VaccinationCenter(
      name: map['name'] ?? '',
      address: map['address'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'address': address,
    };
  }
}
