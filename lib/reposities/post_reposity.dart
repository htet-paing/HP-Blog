import 'dart:io';
import 'package:provider_and_fstore/dao/post_api.dart';
import 'package:provider_and_fstore/model/post.dart';

class PostReposity {
  final postApi = PostApi();

  Future getPosts() => postApi.getPosts();
  Future uploadPostAndImage(Post post, File imageFile, bool isUpdating) => postApi.uploadPostAndImage(post, imageFile, isUpdating); 
  Future deletePost(Post post) => postApi.deletePost(post);

  
}