class FavoriteDestinationPost {
  final String userId;
  final List<String> listIdDestinationPost;
  FavoriteDestinationPost({
    required this.userId,
    required this.listIdDestinationPost,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'listIdDestinationPost': listIdDestinationPost,
    };
  }

  factory FavoriteDestinationPost.fromMap(Map<String, dynamic> map) {
    return FavoriteDestinationPost(
      userId: map['userId'] ?? '',
      listIdDestinationPost: List<String>.from(map['listIdDestinationPost']),
    );
  }
}
