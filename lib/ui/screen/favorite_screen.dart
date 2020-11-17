import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:provider_and_fstore/model/post.dart';
import 'package:provider_and_fstore/provider/bookmark_provider.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  
  @override
  void initState() { 
    super.initState();
    getBookmarks();
  }
  @override
  void deactivate() {
    super.deactivate();
    getBookmarks();
  }

  getBookmarks() {
    SchedulerBinding.instance.addPostFrameCallback((_) { 
      if (mounted) {
        Provider.of<BookmarkProvider>(context, listen: false).getBookmarks();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<BookmarkProvider>(
      builder: (BuildContext context, BookmarkProvider bookmarkProvider, Widget child) {
        return Scaffold(
        body: bookmarkProvider.posts.isEmpty
            ? _buildEmptyListView()
            : _buildListView(bookmarkProvider),
        );
      }
    );
  }

  _buildEmptyListView() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          // Image.asset(
          //   'assets/images/empty.png',
          //   height: 300.0,
          //   width: 300.0,
          // ),
          Text(
            'Nothing is here',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  _buildListView(BookmarkProvider bookmarkProvider) {
    return ListView.builder(
      itemCount: bookmarkProvider.posts.length,
      itemBuilder: (ctx, i) {
        Post post = Post.fromJson(bookmarkProvider.posts[i]['item']);
        return ListTile(
          title: Text(post.title
        ));
      }
    );
  }
}
