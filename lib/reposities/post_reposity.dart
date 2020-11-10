import 'package:provider_and_fstore/dao/post_api.dart';

class PostReposity {
  final postApi = PostApi();

  Future getPosts() => postApi.getPosts();
}