import 'package:flutter/material.dart';

import '../../configs/text_config.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Post {
  final String postId;
  final String sharer;
  final String postName;
  final String description;
  final String province;
  final String district;
  final String wards;
  final String? road;
  final List<String> images;
  final PostType type;
  final double rating;
  final PostStatus status;

  Post({
    required this.postId,
    required this.sharer,
    required this.postName,
    required this.description,
    required this.province,
    required this.district,
    required this.wards,
    this.road,
    required this.images,
    required this.type,
    required this.rating,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'postId': postId,
      'sharer': sharer,
      'postName': postName,
      'description': description,
      'province': province,
      'district': district,
      'wards': wards,
      'road': road,
      'images': images,
      'type': type.value,
      'rating': rating,
      'status': status.value,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '',
      sharer: map['sharer'] ?? '',
      postName: map['postName'] ?? '',
      description: map['description'] ?? '',
      province: map['province'] ?? '',
      district: map['district'] ?? '',
      wards: map['wards'] ?? '',
      road: map['road'],
      images: List<String>.from(map['images']),
      type: PostTypeExtension.fromInt(map['type']),
      rating: map['rating']?.toDouble() ?? 0.0,
      status: PostStatusExtension.fromInt(map['status']),
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

enum PostStatus { pending, approve, decline }

extension PostStatusExtension on PostStatus {
  int get value {
    final values = {
      PostStatus.pending: 1,
      PostStatus.approve: 2,
      PostStatus.decline: 3,
    };

    return values[this]!;
  }

  static PostStatus fromInt(int value) {
    final values = {
      1: PostStatus.pending,
      2: PostStatus.approve,
      3: PostStatus.decline,
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
