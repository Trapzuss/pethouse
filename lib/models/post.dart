import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostModel {
  final String ownerId;
  final String postId;
  final String imageUrl;
  final String title;
  final String description;
  final String animalClass;
  final DateTime createdAt;
  final String? ownerUsername;
  final List favorites;

  const PostModel(
      {required this.ownerId,
      required this.postId,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.animalClass,
      required this.createdAt,
      required this.favorites,
      this.ownerUsername});

  static final List animalClasses = [
    {'value': 'Fishs', 'icon': Icons.pets},
    {'value': 'Amphibians', 'icon': Icons.pets},
    {'value': 'Aves', 'icon': Icons.pets},
    {'value': 'Mammals', 'icon': Icons.pets},
    {'value': 'Reptiles', 'icon': Icons.pets},
    {'value': 'Insecta', 'icon': Icons.pets},
    {'value': 'Cephalopod', 'icon': Icons.pets}
  ];

  static getAnimalClass(int selectedClass) {
    // print('from method $selectedClass');
    return animalClasses[selectedClass]['value'];
  }

  static getAnimalClassIndex(String selectedClass) {
    // final res = animalClasses.indexOf({'value': 'Aves', 'icon': Icons.pets});
    final res =
        animalClasses.singleWhere((item) => item['value'] == selectedClass);
    // log('$selectedClass');
    // log('${animalClasses.indexOf(res)}');
    return animalClasses.indexOf(res);
  }

  Map<String, dynamic> toJson() => {
        'ownerId': ownerId,
        'postId': postId,
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'animalClass': animalClass,
        'createdAt': createdAt,
        'favorites': favorites
      };

  static PostModel fromJson(Map<String, dynamic> json) => PostModel(
      ownerId: json['ownerId'],
      postId: json['postId'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      animalClass: json['animalClass'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
      ownerUsername: json['ownerUsername'],
      favorites: json['favorites']);
}
