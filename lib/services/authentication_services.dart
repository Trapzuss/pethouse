import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/main.dart';
import 'package:pet_house/models/auth.dart';
import 'package:pet_house/models/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final docUsers = FirebaseFirestore.instance.collection('users');
  // check current authState
  Future checkCurrentAuthStateChange() async {
    _firebaseAuth.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in');
      }
    });
  }

  User? get getCurrentUser {
    try {
      if (_firebaseAuth.currentUser != null) {
        return _firebaseAuth.currentUser!;
      }
      return null;
    } on FirebaseAuthException catch (e) {
      BotToast.showNotification(
        crossPage: true,
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.error, color: Colors.red),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 6),
        title: (_) => Text(e.message!),
      );
    }
  }

  String get getUid {
    return getCurrentUser!.uid;
  }

  // sign in anon

  // sign in
  Future signIn(String email, String password) async {
    var close = BotToast.showLoading(crossPage: true);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email.trim(), password: password.trim());
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
      BotToast.showNotification(
        crossPage: true,
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.login, color: Colors.green),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        title: (_) => Text('Login successfully'),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      BotToast.showNotification(
        crossPage: true,
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.error, color: Colors.red),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 6),
        title: (_) => Text(e.message!),
      );
    } finally {
      close();
    }
  }

  // sign up
  Future signUp(String username, String email, String password) async {
    var close = BotToast.showLoading(crossPage: true);
    try {
      final createdUser = await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      final defaultUser = AuthModel(
          uid: createdUser.user!.uid,
          urlPictureProfile: '',
          bio: '',
          username: username,
          email: email,
          password: password,
          createdAt: DateTime.now());

      final userJson = defaultUser.toJson();
      final docUser = docUsers.doc(createdUser.user?.uid);
      docUser.set(userJson);

      BotToast.showNotification(
        crossPage: true,
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.login, color: Colors.green),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        title: (_) => Text('SignUp successfully'),
      );
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    } on FirebaseAuthException catch (e) {
      BotToast.showNotification(
        crossPage: true,
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.error, color: Colors.red),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 6),
        title: (_) => Text(e.message!),
      );
    } finally {
      close();
    }
  }

  // sign out
  Future signOut() async {
    await _firebaseAuth.signOut();
  }
}
