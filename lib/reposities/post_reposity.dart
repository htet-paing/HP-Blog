import 'dart:io';

import 'package:provider_and_fstore/dao/post_api.dart';
import 'package:provider_and_fstore/model/post.dart';
import 'package:provider_and_fstore/model/user.dart';

class PostReposity {
  final postApi = PostApi();


  Future login(AUser user) => postApi.login(user);
  Future signup(AUser user) => postApi.signup(user);
  Future logout() => postApi.logout();

  Future getPosts() => postApi.getPosts();
  Future uploadPostAndImage(Post post, File imageFile, bool isUpdating) => postApi.uploadPostAndImage(post, imageFile, isUpdating); 
}