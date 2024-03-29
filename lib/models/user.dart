import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String urlPictureProfile;
  final String username;
  final String bio;
  final String email;
  final DateTime createdAt;

  const UserModel(
      {required this.uid,
      required this.urlPictureProfile,
      required this.username,
      required this.bio,
      required this.email,
      required this.createdAt});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'urlPictureProfile': urlPictureProfile,
        'username': username,
        'bio': bio,
        'email': email,
        'createdAt': createdAt
      };

  static UserModel fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        urlPictureProfile: json['urlPictureProfile'],
        username: json['username'],
        bio: json['bio'],
        email: json['email'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );
}
