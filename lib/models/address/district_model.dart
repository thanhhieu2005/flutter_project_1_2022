class District {
  final int codeDistrict;
  final String nameDistrict;
  final String nameProvince;

  District({
    required this.codeDistrict,
    required this.nameDistrict,
    required this.nameProvince,
  });

  Map<String, dynamic> toMap() {
    return {
      'codeDistrict': codeDistrict,
      'nameDistrict': nameDistrict,
      'nameProvince': nameProvince,
    };
  }

  factory District.fromMap(Map<String, dynamic> map) {
    return District(
      codeDistrict: int.tryParse(map['code']) ?? 0,
      nameDistrict: map['name'] ?? '',
      nameProvince: map['province'] ?? '',
    );
  }
}
