class FavoriteDestinationPost {
  final String userId;
  final List<String> listIdDestinantionPost;
  FavoriteDestinationPost({
    required this.userId,
    required this.listIdDestinantionPost,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'listIdDestinantionPost': listIdDestinantionPost,
    };
  }

  factory FavoriteDestinationPost.fromMap(Map<String, dynamic> map) {
    return FavoriteDestinationPost(
      userId: map['userId'] ?? '',
      listIdDestinantionPost: List<String>.from(map['listIdDestinantionPost']),
    );
  }
}
