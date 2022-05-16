import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CollectionModel {
  final String collectionId;
  final String uid;
  final List<dynamic> postsId;
  final String collectionName;
  final DateTime createdAt;

  const CollectionModel({
    required this.collectionId,
    required this.uid,
    required this.postsId,
    required this.collectionName,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
        'collectionId': collectionId,
        'uid': uid,
        'postsId': postsId,
        'collectionName': collectionName,
        'createdAt': createdAt
      };

  static CollectionModel fromJson(Map<String, dynamic> json) => CollectionModel(
        collectionId: json['collectionId'],
        uid: json['uid'],
        postsId: json['postsId'],
        collectionName: json['collectionName'],
        createdAt: (json['createdAt'] as Timestamp).toDate(),
      );
}
