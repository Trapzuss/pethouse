// ignore_for_file: unnecessary_new

import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/api/firebase_api.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/post/animalClassSelection.dart';
import 'package:pet_house/widget/post/mediaAction.dart';
import 'package:pet_house/widget/post/postForm.dart';
import 'package:path/path.dart';

class updatePostScreen extends StatefulWidget {
  final post;
  const updatePostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<updatePostScreen> createState() => _updatePostScreenState();
}

class _updatePostScreenState extends State<updatePostScreen> {
  final bool isLoading = false;
  late final ValueChanged<bool> onLoadingChanged;
  int _selectedClass = -1;
  // UploadTask? task;
  // File? uploadFile;

  void _handleLoading() {
    onLoadingChanged(!isLoading);
  }

  // void pickImage(newMedia) {
  //   setState(() {
  //     this.uploadFile = File(newMedia.path);
  //     // this.uploadFile = newMedia;
  //   });
  // }

  final GlobalKey<FormState> _postFormKey = GlobalKey<FormState>();
  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  Future changingClass(newClass) async {
    setState(() {
      _selectedClass = newClass;
    });
  }

  loadPostData() {
    int indexOfClass = PostModel.getAnimalClassIndex(
        widget.post['animalClass'].toString().trim());
    _controllerTitle.text = widget.post['title'];
    _controllerDescription.text = widget.post['description'];

    setState(() {
      _selectedClass = indexOfClass;
    });
  }

  Future updatePost(context) async {
    // #validateForm
    final isValid = _postFormKey.currentState!.validate();
    if (!isValid) return;
    if (_selectedClass == -1) {
      String errorMessage = '';
      if (_selectedClass == -1) errorMessage = 'Animal class is required.';

      return;
    }
    var close = BotToast.showLoading();

    // #create document on firestore
    final title = _controllerTitle.text;
    final description = _controllerDescription.text;
    await PostServices()
        .updatePost(widget.post['postId'], title, description, _selectedClass);

    close();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    loadPostData();
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () async {
                  PostServices().deletePost(widget.post['postId'], context);
                },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Icon(
                        Icons.delete,
                      ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.red,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16)))),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () async {
                  await updatePost(context);
                },
                child: isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : const Text('SAVE'),
                style: ElevatedButton.styleFrom(
                    primary: AppTheme.colors.primaryFontColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(16)))),
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          !keyboardIsOpen
              ? Container(
                  margin: const EdgeInsets.only(top: 12),
                  padding: const EdgeInsets.all(8),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      widget.post['imageUrl']!,
                      height: 200,
                      fit: BoxFit.contain,
                    ),
                  ))
              : Container(margin: const EdgeInsets.symmetric(vertical: 10)),
          PostForm(
              postFormKey: _postFormKey,
              controllerTitle: _controllerTitle,
              controllerDescription: _controllerDescription),
          Container(
            child: Column(
              children: [
                new AnimalsClassSelection(
                    selectedClass: _selectedClass, callback: changingClass),
                // mediaAction(action: pickImage)
              ],
            ),
          )
        ],
      ),
    );
  }
}
