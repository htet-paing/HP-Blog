import 'dart:collection';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:provider_and_fstore/database/bookmark_db.dart';
import 'package:provider_and_fstore/model/post.dart';
import '../reposities/post_reposity.dart';

class PostProvider with ChangeNotifier {
  final _postReposity = PostReposity();
    
  List<Post> _postList = [];
  Post _currentPost;

  BookmarkDB bookmarkDB = BookmarkDB();

  bool bookmarked = false;

  UnmodifiableListView<Post> get postList => UnmodifiableListView(_postList);

  Post get currentPost => _currentPost;

  List<Post> findPostwithSymbol(String catSymbol) {
     return _postList.where((post) => post.catogory.contains(catSymbol)).toList();
  }

  set postList(List<Post> postList) {
    _postList = postList;
    notifyListeners();
  }

  set currentPost(Post post) {
    _currentPost = post;
    notifyListeners();
  }

  Future<void> getPosts() async {
    this.postList = await _postReposity.getPosts();
    notifyListeners();    
  }


  Future<void> uploadPostAndImage(Post post, File imageFile, bool isUpdating) async {
     await _postReposity.uploadPostAndImage(post, imageFile, isUpdating);
    notifyListeners();
  }

  Future<void> deletePost(Post post) async {
    await _postReposity.deletePost(post);
    _postList.removeWhere((_post) => _post.id == post.id);
    notifyListeners();
  }

  
  //check if post is bookmarked
  checkBookmark() async {
    List c = await bookmarkDB.check({'id' : currentPost.id.toString()});
    if (c.isNotEmpty) {
      setBookmarked(true);
    }else {
      setBookmarked(false);
    }
  }

  void setBookmarked(value) {
    bookmarked = value;
    notifyListeners();
  }

  addBookmark() async {
    await bookmarkDB.add({'id' : currentPost.id.toString(), 'item': currentPost.toJson()});
    checkBookmark();
  }

  removeBookmark() async {
    bookmarkDB.remove({'id' : currentPost.id.toString()}).then((v) {
      print(v);
      checkBookmark();
    });
  }
}