import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final DateTime createdAt;

  const Post(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.createdAt});

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'createdAt': createdAt
      };

  static Post fromJson(Map<String, dynamic> json) => Post(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      createdAt: (json['createdAt'] as Timestamp).toDate());
}
