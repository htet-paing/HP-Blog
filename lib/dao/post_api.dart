import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider_and_fstore/model/post.dart';


class PostApi {

  Future<List<Post>> getPosts() async {
    Query snapshot = FirebaseFirestore.instance
    .collection('Posts')
    .orderBy("createdAt", descending: true);
    List<Post> _postList = [];

    await snapshot.get().then((querySnapshot) async {
      querySnapshot.docs.forEach((document) {
        Post post = Post.fromJson(document.data());
        _postList.add(post);
      });
    });
    return _postList;
  }
  
}