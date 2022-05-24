import 'package:flutter_project_1/models/category_model.dart';
import 'package:flutter_project_1/models/post.dart';
import 'package:flutter_project_1/view_models/post_provider.dart';

class PostDetailArgument {
  final PostProvider provider;
  final Post post;

  PostDetailArgument(this.provider, this.post);
}

class TypeScreenArgument {
  final PostProvider provider;
  final Category category;

  TypeScreenArgument(this.provider, this.category);
}
