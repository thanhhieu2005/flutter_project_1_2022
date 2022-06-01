import 'package:flutter/material.dart';

import '../../configs/text_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Post {
  final String idPost;
  final String sharer;
  final String postName;
  final String description;
  final String province;
  final String district;
  final String? road;
  final List<String> images;
  final PostType type;
  final double rating;

  Post({
    required this.idPost,
    required this.sharer,
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
      'sharer': sharer,
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
      sharer: map['sharer'] ?? '',
      postName: map['postName'] ?? '',
      description: map['description'] ?? '',
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      road: map['road'],
      images: List<String>.from(map['images']),
      type: PostTypeExtension.fromInt(map['type']),
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }
}

enum PostType { beach, mountain, island, city }

extension PostTypeExtension on PostType {
  int get value {
    final values = {
      PostType.beach: 1,
      PostType.mountain: 2,
      PostType.island: 3,
      PostType.city: 4,
    };

    return values[this]!;
  }

  static PostType fromInt(int value) {
    final values = {
      1: PostType.beach,
      2: PostType.mountain,
      3: PostType.island,
      4: PostType.city,
    };

    return values[value]!;
  }
}

class SettingPostType {
  static List<DropdownMenuItem<PostType>> listType = [
    DropdownMenuItem(
      child: Text(
        'Beach',
        style: TextConfigs.kText16Black,
      ),
      value: PostType.beach,
    ),
    DropdownMenuItem(
      child: Text(
        'Mountain',
        style: TextConfigs.kText16Black,
      ),
      value: PostType.mountain,
    ),
    DropdownMenuItem(
      child: Text(
        'Island',
        style: TextConfigs.kText16Black,
      ),
      value: PostType.island,
    ),
    DropdownMenuItem(
      child: Text(
        'City',
        style: TextConfigs.kText16Black,
      ),
      value: PostType.city,
    ),
  ];

  static String setTitleType(PostType postType, BuildContext context) {
    String type = "";
    switch (postType) {
      case PostType.beach:
        type = AppLocalizations.of(context).beach;
        break;
      case PostType.mountain:
        type = AppLocalizations.of(context).mountain;
        break;
      case PostType.island:
        type = AppLocalizations.of(context).island;
        break;
      case PostType.city:
        type = AppLocalizations.of(context).city;
        break;
    }
    return type;
  }

  static String getIntroType(PostType postType, BuildContext context) {
    String type = "";
    switch (postType) {
      case PostType.beach:
        type = AppLocalizations.of(context).introBeach;
        break;
      case PostType.mountain:
        type = AppLocalizations.of(context).introMountain;
        break;
      case PostType.island:
        type = AppLocalizations.of(context).introIsland;
        break;
      case PostType.city:
        type = AppLocalizations.of(context).introCity;
        break;
    }
    return type;
  }
}