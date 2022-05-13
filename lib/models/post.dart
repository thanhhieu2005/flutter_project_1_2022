import 'dart:convert';

class Post {
  final String idPost;
  final String idUser;
  final String postName;
  final String description;
  final String province;
  final String district;
  final String? road;
  final List<String> images;
  final int type;
  final double rating;

  Post({
    required this.idPost,
    required this.idUser,
    required this.postName,
    required this.description,
    required this.province,
    required this.district,
    this.road,
    required this.images,
    required this.type,
    required this.rating,
  });

  Map<String, dynamic> toMap() {
    return {
      'idPost': idPost,
      'idUser': idUser,
      'postName': postName,
      'description': description,
      'province': province,
      'district': district,
      'road': road,
      'images': images,
      'type': type,
      'rating': rating,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      idPost: map['idPost'] ?? '',
      idUser: map['idUser'] ?? '',
      postName: map['postName'] ?? '',
      description: map['description'] ?? '',
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      road: map['road'],
      images: List<String>.from(map['images']),
      type: map['type']?.toInt() ?? 0,
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }
}
