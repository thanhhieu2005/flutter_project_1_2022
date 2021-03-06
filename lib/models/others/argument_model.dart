import 'package:flutter_project_1/models/others/category_model.dart';
import 'package:flutter_project_1/models/posts/destination_post.dart';
import 'package:flutter_project_1/models/users/user.dart';
import 'package:flutter_project_1/view_models/post/destination_post_provider.dart';
import 'package:flutter_project_1/view_models/post/post_moderation_provider.dart';

import '../../view_models/discovery/discovery_provider.dart';

class DestinationPostDetailArgument {
  final DestinationPost post;
  final VatractionUser sharer;

  DestinationPostDetailArgument(this.post, this.sharer);
}

class PostModerationArgument {
  final PostModerationProvider provider;
  final DestinationPost post;
  final VatractionUser sharer;

  PostModerationArgument(this.provider, this.post, this.sharer);
}

class TypeScreenArgument {
  final DestinationPostProvider provider;
  final Category category;

  TypeScreenArgument(this.provider, this.category);
}

class SearchScreenArgument {
  final bool isModeration;

  SearchScreenArgument(this.isModeration);
}

class DiscoveryDetailArgument {
  final Category category;
  final DiscoveryProvider provider;
  DiscoveryDetailArgument(this.category, this.provider);
}
