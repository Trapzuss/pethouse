import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/models/auth.dart';
import 'package:pet_house/models/user.dart';
import 'package:pet_house/services/authentication_services.dart';

class UserServices {
  final docUsers = FirebaseFirestore.instance.collection('users');
  Future<UserModel> getUserByUid(id) async {
    final docUser = docUsers.doc(id);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
    return UserModel(
        uid: '',
        urlPictureProfile: '',
        username: '',
        bio: '',
        email: '',
        createdAt: DateTime.now());
  }

  Future<UserModel> getCurrentUser() async {
    final docUser = docUsers.doc(AuthenticationService().getUid);
    final snapshot = await docUser.get();

    if (snapshot.exists) {
      return UserModel.fromJson(snapshot.data()!);
    }
    return UserModel(
        uid: '',
        urlPictureProfile: '',
        username: '',
        bio: '',
        email: '',
        createdAt: DateTime.now());
  }

  Future onSubmitProfile(String username, String bio, String url) async {
    try {
      String urlDownload;
      if (url != '' || url != null) {
        await docUsers.doc(AuthenticationService().getUid).update(
            {'username': username, 'bio': bio, 'urlPictureProfile': url});
      } else {
        await docUsers
            .doc(AuthenticationService().getUid)
            .update({'username': username, 'bio': bio});
      }
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
}
