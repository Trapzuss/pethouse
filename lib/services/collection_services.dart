import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/models/collection.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/utils/utils.dart';

class CollectionServices {
  final docCollections = FirebaseFirestore.instance.collection('collections');
  Future createCollection(collectionName) async {
    try {
      final docCollection =
          FirebaseFirestore.instance.collection('collections').doc();
      var close = BotToast.showLoading();
      final collection = CollectionModel(
        collectionId: docCollection.id,
        uid: AuthenticationService().getUid,
        postsId: [],
        collectionName: collectionName,
        createdAt: DateTime.now(),
      );
      final collectionJson = collection.toJson();
      await docCollection.set(collectionJson);
      close();
      BotToast.showNotification(
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        title: (_) => Text("Done! let's add some post"),
      );
    } catch (e) {
      BotToast.showNotification(
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.check_circle, color: Colors.red),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        title: (_) => Text('Something wrong! please try again later.'),
      );
    }
  }

  Stream<List<CollectionModel>> getCollectionsOfCurrentUser() => docCollections
      // .where('uid', isEqualTo: AuthenticationService().getUid)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => CollectionModel.fromJson(doc.data()))
          .toList());

  Future<List<PostModel?>> getPostsInCollection(List<dynamic> postsId) async {
    final List<PostModel?> postList = [];
    for (var postId in postsId) {
      final post = await PostServices().getPostById(postId.toString().trim());
      postList.add(post);
    }
    // log('$postList');
    return postList;
  }

  Future onChangeCollection(
      String action, String collectionId, String postId) async {
    final docCollection = await docCollections.doc(collectionId.trim());
    final snapshot = await docCollection.get();
    if (snapshot.exists) {
      final collectionJson = CollectionModel.fromJson(snapshot.data()!);
      final List collectionPostList = collectionJson.postsId;

      //#add
      if (action == 'add') {
        collectionPostList.add(postId.toString().trim());
      }
      // #remove
      else {
        collectionPostList.removeWhere((postIdValue) =>
            postIdValue.toString().trim() == postId.toString().trim());
      }

      // log('${collectionPostList}');
      docCollections
          .doc(collectionId.trim())
          .update({'postsId': collectionPostList});
    }
  }
}
