import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/main.dart';
import 'package:pet_house/models/post.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'dart:developer';

class PostServices {
  final docPosts = FirebaseFirestore.instance.collection('posts');

  Future createPost(int selectedClass, String urlDownload, String title,
      String description) async {
    try {
      // #create document on firestore
      final docPost = FirebaseFirestore.instance.collection('posts').doc();
      final post = PostModel(
          ownerId: AuthenticationService().getUid,
          postId: docPost.id,
          imageUrl: urlDownload,
          title: title,
          description: description == '' ? '' : description,
          animalClass: PostModel.getAnimalClass(selectedClass),
          createdAt: DateTime.now(),
          favorites: []);

      final postJson = post.toJson();
      await docPost.set(postJson);

      BotToast.showNotification(
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 1),
        title: (_) => Text('Done! check you post'),
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

  Stream<List<PostModel>> getPosts() => docPosts.snapshots().map((snapshot) =>
      snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList());

  Future<PostModel?> getPostById(id) async {
    try {
      // log('services postId:${id}');
      final docPost = docPosts.doc(id.toString().trim());
      final snapshot = await docPost.get();

      if (snapshot.exists) {
        final res = PostModel.fromJson(snapshot.data()!);
        // log('data:${res.imageUrl}');
        return res;
      }
      return null;
    } catch (e) {
      print(e);
    }
  }

  Stream<List<PostModel>> getUserPosts(uid) {
    final userPosts = docPosts.where('ownerId', isEqualTo: uid).snapshots().map(
        (snapshot) => snapshot.docs
            .map((doc) => PostModel.fromJson(doc.data()))
            .toList());

    return userPosts;
  }

  Stream<List<PostModel>> getPostsByAnimalClass(String animalClass) => docPosts
      .where('animalClass', isEqualTo: animalClass)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => PostModel.fromJson(doc.data())).toList());

  Stream<List<PostModel>> getPostsBySearching(String keyword) {
    return docPosts.snapshots().map((snapshot) => snapshot.docs
        .map((doc) => PostModel.fromJson(doc.data()))
        .where((post) =>
            post.title.toLowerCase().contains(keyword.toLowerCase()) ||
            post.description.toLowerCase().contains(keyword.toLowerCase()) ||
            post.animalClass.toLowerCase().contains(keyword.toLowerCase()))
        .toList());
  }

  Future onChangeFavorites(String action, String postId, String uid) async {
    final docPost = docPosts.doc(postId.trim());
    final snapshot = await docPost.get();
    if (snapshot.exists) {
      final postJson = PostModel.fromJson(snapshot.data()!);
      final List favoriteList = postJson.favorites;

      //#add
      if (action == 'add') {
        favoriteList.add(uid.toString().trim());
      }
      // #remove
      else {
        favoriteList.removeWhere(
            (uidValue) => uidValue.toString().trim() == uid.toString().trim());
      }
      // log('$favoriteList');
      docPosts.doc(postId.trim()).update({'favorites': favoriteList});
    }
  }

  Future updatePost(
    String postId,
    String title,
    String description,
    int animalClass,
  ) async {
    try {
      final docPost = docPosts.doc(postId.trim());
      final snapshot = await docPost.get();

      await docPost.update({
        'title': title,
        'description': description,
        'animalClass': PostModel.getAnimalClass(animalClass)
      });
      BotToast.showNotification(
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.check_circle, color: Colors.green),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 1),
        title: (_) => Text('Your post has been updated.'),
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

  Future deletePost(String postId, context) async {
    try {
      final docPost = docPosts.doc(postId.trim());
      // final snapshot = await docPost.get();
      // if (snapshot.exists) {
      //   final postJson = PostModel.fromJson(snapshot.data()!);
      // }

      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.SCALE,
        title: "Delete this post?",
        desc:
            'This post will dissapear from you profile and the feed. are you sure?',
        btnCancelText: 'Cancel',
        btnOkText: 'Delete',
        btnOkColor: Colors.red,
        btnCancelColor: Colors.white,
        dialogBackgroundColor: Color.fromARGB(255, 245, 245, 245),
        buttonsTextStyle: TextStyle(color: Color.fromARGB(255, 20, 20, 20)),
        btnCancelOnPress: () {
          return;
        },
        btnOkOnPress: () async {
          await docPost.delete();
          navigatorKey.currentState!.popUntil((route) => route.isFirst);
          BotToast.showNotification(
            crossPage: true,
            leading: (cancel) => SizedBox.fromSize(
                size: const Size(40, 40),
                child: IconButton(
                  icon: Icon(Icons.delete_forever, color: Colors.red),
                  onPressed: cancel,
                )),
            duration: Duration(seconds: 1),
            title: (_) => Text('The post has been deleted.'),
          );
        },
      ).show();
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

  Future<int> getAmountOfPostsOfUserByUid(String uid) async {
    // final listener = docPosts
    //     .where('ownerId', isEqualTo: uid.toString().trim())
    //     .snapshots()
    //     .listen((event) {
    //   final cities = [];
    //   for (var doc in event.docs) {
    //     cities.add(doc.data()["name"]);
    //   }
    //   log("cities in CA: ${cities.join(", ")}");
    // });
    // listener.cancel();

    // docPosts.snapshots().listen((event) {
    //   for (var doc in event.docs) {
    //     posts.add(doc.data());
    //   }
    // });

    final QuerySnapshot qSnap =
        await docPosts.where('ownerId', isEqualTo: uid).get();
    final int docs = qSnap.docs.length;
    // log("${docs}");
    return docs;
  }

  Future<int> getAmountOfFavoritesOfUserByUid(String uid) async {
    int amountOfFavorites = 0;
    final QuerySnapshot qSnap =
        await docPosts.where('ownerId', isEqualTo: uid.trim()).get();
    for (QueryDocumentSnapshot<dynamic> doc in qSnap.docs) {
      amountOfFavorites += doc.data()!["favorites"].length as int;
    }

    // log('${amountOfFavorites}');
    return amountOfFavorites;
  }
}
