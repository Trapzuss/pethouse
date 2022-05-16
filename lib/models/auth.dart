import 'package:cloud_firestore/cloud_firestore.dart';

class AuthModel {
  final String uid;
  final String urlPictureProfile;
  final String username;
  final String bio;
  final String email;
  final String password;
  final DateTime createdAt;

  const AuthModel(
      {required this.uid,
      required this.urlPictureProfile,
      required this.username,
      required this.bio,
      required this.email,
      required this.password,
      required this.createdAt});

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'urlPictureProfile': urlPictureProfile,
        'username': username,
        'bio': bio,
        'email': email,
        'password': password,
        'createdAt': createdAt
      };

  static AuthModel fromJson(Map<String, dynamic> json) => AuthModel(
        uid: json['uid'],
        urlPictureProfile: json['urlPictureProfile'],
        username: json['username'],
        bio: json['bio'],
        email: json['email'],
        password: json['password'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );
}
