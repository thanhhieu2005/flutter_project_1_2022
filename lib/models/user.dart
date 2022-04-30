class User {
  final String uid;
  final String? email;
  final String? userName;
  final String? dateOfBirth;
  final String? avatarUrl;
  final String? gender;
  User(
      {required this.uid,
      this.email,
      this.userName,
      this.avatarUrl,
      this.dateOfBirth,
      this.gender});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'email': email,
        'userName': userName ?? "",
        'avatarUrl': avatarUrl ?? "",
        'dateOfBirth': dateOfBirth ?? "",
        'gender': gender ?? ""
      };

  User.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        email = json['email'],
        uid = json['uid'],
        avatarUrl = json['avatarUrl'],
        dateOfBirth = json['dateOfBirth'],
        gender = json['gender'];
}
