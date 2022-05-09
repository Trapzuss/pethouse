import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Post {
  final String id;
  final String imageUrl;
  final String title;
  final String description;
  final String animalClass;
  final DateTime createdAt;

  const Post(
      {required this.id,
      required this.imageUrl,
      required this.title,
      required this.description,
      required this.animalClass,
      required this.createdAt});

  static final animalClasses = [
    {'value': 'Fish', 'icon': Icons.pets},
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'imageUrl': imageUrl,
        'title': title,
        'description': description,
        'animalClass': animalClass,
        'createdAt': createdAt
      };

  static Post fromJson(Map<String, dynamic> json) => Post(
      id: json['id'],
      imageUrl: json['imageUrl'],
      title: json['title'],
      description: json['description'],
      animalClass: json['animalClass'],
      createdAt: (json['createdAt'] as Timestamp).toDate());
}
