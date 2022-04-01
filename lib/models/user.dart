class User {
  final String uid;
  final String? email;
  User({
    required this.uid,
    this.email,
  });

  Map<String, dynamic> toJson() => {'uid': uid, 'email': email};
}
