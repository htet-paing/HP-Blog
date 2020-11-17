import 'package:flutter/foundation.dart';
import 'package:provider_and_fstore/database/bookmark_db.dart';

class BookmarkProvider with ChangeNotifier {
  List posts = List();
  bool loading = true;
  BookmarkDB db = BookmarkDB();

  void setLoading(value) {
    loading = value;
    notifyListeners();
  }

  void setPosts(value) {
    posts = value;
    notifyListeners();
  }

  List getPosts() {
    return posts;
  }

  getBookmarks() async {
    setLoading(true);
    posts.clear();
    List all = await db.listAll();
    posts.addAll(all);
    setLoading(false);
  }
}