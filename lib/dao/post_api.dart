import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider_and_fstore/model/post.dart';
import 'package:path/path.dart'as path;
import 'package:uuid/uuid.dart';

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

  Future<void> uploadPostAndImage(Post post, File localImage, bool isUpdating) async {
    if (localImage != null) {
      print("Uploading Image");

      var fileExtension = path.extension(localImage.path);
      print("FileExtension : $fileExtension");
      
      var uuId = Uuid().v4();

      final StorageReference firebaseStorageRef = 
      FirebaseStorage.instance.ref().child('posts/images/$uuId$fileExtension');
      await firebaseStorageRef.putFile(localImage).onComplete.catchError((onError) {
        print(onError);
        return false;
      });
      

      String url = await firebaseStorageRef.getDownloadURL();
      print("Download URL : $url");
      
      //Upload Post
      _uploadPost(post, isUpdating, imageUrl: url);
    }else {
      print("....Skipping image Upload");
      _uploadPost(post, isUpdating);
    }
  }

  _uploadPost(Post post, bool isUpdating, {String imageUrl}) async {
    CollectionReference postRef = FirebaseFirestore.instance.collection('Posts');
    if (imageUrl != null) {
      post.image = imageUrl;
    }

    if (isUpdating) {
      //Update Post
     
    }else {
      //Create POst
      post.createdAt = Timestamp.now();
      DocumentReference documentRef  = await postRef.add(post.toJson());
      post.id = documentRef.id;
      print("Uploaded Post SuccessFully : ${post.toString()}");
      
      await documentRef.set(post.toJson());
    }
  }
  
}