class Province {
  final int code;
  final String nameProvince;

  Province(
    this.code,
    this.nameProvince,
  );

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'nameProvince': nameProvince,
    };
  }

  factory Province.fromMap(Map<String, dynamic> map) {
    return Province(
      int.tryParse(map['code']) ?? 0,
      map['name'] ?? '',
    );
  }
}
