class VatractionUser {
  String? uid;
  final String email;
  final String? userName;
  final String? dateOfBirth;
  final String? avatarUrl;
  final String? gender;
  final String pwd;
  bool isConfirmEmail;
  VatractionUser(
      {required this.uid,
      required this.email,
      this.userName,
      this.avatarUrl,
      this.dateOfBirth,
      this.gender,
      required this.pwd,
      this.isConfirmEmail = false});

  Map<String, Object?> toJson() => {
        'uid': uid,
        'email': email,
        'userName': userName ?? "",
        'avatarUrl': avatarUrl ?? "",
        'dateOfBirth': dateOfBirth ?? "",
        'gender': gender ?? "",
        'pwd': pwd,
        'isConfirmEmail': isConfirmEmail,
      };

  VatractionUser.fromJson(Map<String, Object?> json)
      : userName = json['userName'] as String,
        email = json['email'] as String,
        uid = json['uid'] as String,
        avatarUrl = json['avatarUrl'] as String,
        dateOfBirth = json['dateOfBirth'] as String,
        gender = json['gender'] as String,
        pwd = json['pwd'] as String,
        isConfirmEmail = json['isConfirmEmail'] as bool;
}
