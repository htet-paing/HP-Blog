import 'dart:collection';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:provider_and_fstore/model/post.dart';
import '../reposities/post_reposity.dart';

class PostProvider with ChangeNotifier {
  final _postReposity = PostReposity();
  
  List<Post> _postList = [
    Post(
      id: 'p1',
      title: "US Election",
      description: "This is US Election",
      image: 'https://i1.wp.com/www.dailyustimes.com/wp-content/uploads/2020/07/Major-US-figures-Twitter-accounts-hacked-in-Bitcoin-scam.jpg',
      catogory: [
        'political',
        'science'
      ],
    ),
    Post(
      id: 'p2',
      title: "Joe Biden",
      description: "This is Joe Biden",
      image: 'https://i1.wp.com/www.dailyustimes.com/wp-content/uploads/2020/07/Major-US-figures-Twitter-accounts-hacked-in-Bitcoin-scam.jpg',
      catogory: [
        'technology',
        'programming'
      ],
    ),
  ];
  Post _currentPost;

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

  Future<void> createPost(Post post, File imageFile) async {

    
  }

  
}