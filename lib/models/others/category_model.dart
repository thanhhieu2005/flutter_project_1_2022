import 'package:flutter_project_1/models/posts/destination_post.dart';

class Category {
  final String icon, title, thumb, intro;
  final PostType type;

  Category({
    required this.icon,
    required this.title,
    required this.thumb,
    required this.intro,
    required this.type,
  });
}


// enum TypePost { Beach, Mountain, Island, City }

// extension TypePostExtension on TypePost {
//   int get value {
//     final values = {
//       TypePost.Beach: 1,
//       TypePost.Mountain: 2,
//       TypePost.Island: 3,
//       TypePost.City: 4
//     };

//     return values[this]!;
//   }

//   static TypePost fromInt(int value) {
//     final values = {
//       1: TypePost.Beach,
//       2: TypePost.Mountain,
//       3: TypePost.Island,
//       4: TypePost.City
//     };

//     return values[value]!;
//   }
// }
