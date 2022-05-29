class Wards {
  final int code;
  final String nameWards;
  final String nameDistrict;
  final String nameProvince;
  Wards({
    required this.code,
    required this.nameWards,
    required this.nameDistrict,
    required this.nameProvince,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'nameWards': nameWards,
      'nameDistrict': nameDistrict,
      'nameProvince': nameProvince,
    };
  }

  factory Wards.fromMap(Map<String, dynamic> map) {
    return Wards(
      code: int.tryParse(map['code']) ?? 0,
      nameWards: map['name'] ?? '',
      nameDistrict: map['district'] ?? '',
      nameProvince: map['province'] ?? '',
    );
  }
}
