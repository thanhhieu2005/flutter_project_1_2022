import 'package:equatable/equatable.dart';

class VatractionUser extends Equatable {
  final String uid;
  final String email;
  final String? userName;
  final String? dateOfBirth;
  final String? avatarUrl;
  final String? gender;
  final String pwd;
  final bool? isConfirmEmail;
  final int? role;
  const VatractionUser(
      {required this.uid,
      required this.email,
      this.userName,
      this.avatarUrl,
      this.dateOfBirth,
      this.gender,
      required this.pwd,
      this.role,
      this.isConfirmEmail = false});

  Map<String, Object?> toJson() => {
        'uid': uid,
        'email': email,
        'userName': userName ?? "",
        'avatarUrl': avatarUrl ?? "",
        'dateOfBirth': dateOfBirth ?? "",
        'gender': gender ?? "",
        'pwd': pwd,
        'isConfirmEmail': isConfirmEmail ?? false,
        'role': role ?? 1,
      };

  VatractionUser.fromJson(Map<String, Object?> json)
      : userName = json['userName'] as String,
        email = json['email'] as String,
        uid = json['uid'] as String,
        avatarUrl = json['avatarUrl'] as String,
        dateOfBirth = json['dateOfBirth'] as String,
        gender = json['gender'] as String,
        pwd = json['pwd'] as String,
        isConfirmEmail = json['isConfirmEmail'] as bool,
        role = json['role'] as int;

  @override
  List<Object?> get props => [
        uid,
        email,
        userName,
        dateOfBirth,
        avatarUrl,
        gender,
        pwd,
        isConfirmEmail,
        role,
      ];

  VatractionUser copyWith({
    String? uid,
    String? email,
    String? userName,
    String? dateOfBirth,
    String? avatarUrl,
    String? gender,
    String? pwd,
    bool? isConfirmEmail,
    int? role,
  }) {
    return VatractionUser(
      uid: uid ?? this.uid,
      email: email ?? this.email,
      userName: userName ?? this.userName,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gender: gender ?? this.gender,
      pwd: pwd ?? this.pwd,
      isConfirmEmail: isConfirmEmail ?? this.isConfirmEmail,
      role: role ?? this.role,
    );
  }
}

enum RoleType { admin, user }

extension RoleTypeExtension on RoleType {
  int get value {
    final values = {
      RoleType.admin: 1,
      RoleType.user: 2,
    };

    return values[this]!;
  }

  static RoleType fromInt(int value) {
    final values = {
      1: RoleType.admin,
      2: RoleType.user,
    };

    return values[value]!;
  }
}
