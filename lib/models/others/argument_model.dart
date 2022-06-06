import 'package:flutter_project_1/models/others/category_model.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/view_models/post/destination_post_provider.dart';

class PostDetailArgument {
  final DestinationPost post;
  final VatractionUser sharer;

  PostDetailArgument(this.post, this.sharer);
}

class TypeScreenArgument {
  final DestinationPostProvider provider;
  final Category category;

  TypeScreenArgument(this.provider, this.category);
}
