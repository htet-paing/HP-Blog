import 'package:cloud_firestore/cloud_firestore.dart';
class Post {
  String id;
  String title;
  String description;
  String image;
  List<dynamic> catogory;
  Timestamp createdAt;
  Timestamp updatedAt;

  Post({
    this.id, 
    this.title,
    this.description, 
    this.image, 
    this.catogory, 
    this.createdAt, 
    this.updatedAt
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    
    return Post(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      image: json['image'],
      catogory: json['catogory'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'title': title,
      'description': description,
      'image': image,
      'category': catogory,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}

