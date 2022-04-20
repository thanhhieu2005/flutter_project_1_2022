class User {
  final String uid;
  final String? email;
  final String? userName;
  User({
    required this.uid,
    this.email,
    this.userName,
  });

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};

  User.fromJson(Map<String, dynamic> json)
      : userName = json['userName'],
        email = json['email'],
        uid = json['uid'];
}
