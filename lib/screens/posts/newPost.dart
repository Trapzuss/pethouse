import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/api/firebase_api.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/post/animalClassSelection.dart';
import 'package:pet_house/widget/post/mediaAction.dart';
import 'package:pet_house/widget/post/postForm.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:bot_toast/bot_toast.dart';
// import 'package:uuid/uuid.dart';

import 'package:path/path.dart';

class newPost extends StatefulWidget {
  const newPost({Key? key}) : super(key: key);

  @override
  State<newPost> createState() => _newPostState();
}

class _newPostState extends State<newPost> {
  // var uuid = Uuid();

  final bool isLoading = false;
  late final ValueChanged<bool> onLoadingChanged;
  int _selectedClass = -1;
  UploadTask? task;
  File? uploadFile;

  void _handleLoading() {
    onLoadingChanged(!isLoading);
  }

  void pickImage(newMedia) {
    setState(() {
      this.uploadFile = File(newMedia.path);
      // this.uploadFile = newMedia;
    });
  }

  final GlobalKey<FormState> _postFormKey = GlobalKey<FormState>();
  final _controllerTitle = TextEditingController();
  final _controllerAnimalName = TextEditingController();
  final _controllerDescription = TextEditingController();

  Future changingClass(newClass) async {
    setState(() {
      _selectedClass = newClass;
    });
  }

  Future createPost(context) async {
    // #validateForm
    final isValid = _postFormKey.currentState!.validate();
    if (!isValid) return;
    if (_selectedClass == -1 || uploadFile == null) {
      String errorMessage = '';
      if (_selectedClass == -1) errorMessage = 'Animal class is required.';
      if (uploadFile == null)
        errorMessage = 'Please choose you picture for upload.';
      BotToast.showNotification(
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.info, color: Colors.amber),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        title: (_) => Text(errorMessage),
      );

      return;
    }
    var close = BotToast.showLoading();
    // #upload file to storage
    if (uploadFile == null) return;
    final fileName = '${basename(uploadFile!.path)}${DateTime.now()}';
    final destination = "files/$fileName";
    task = FirebaseApi.uploadFile(destination, uploadFile!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();

    // #create document on firestore
    String title = _controllerTitle.text;
    String description = _controllerDescription.text;
    String animalName = _controllerAnimalName.text;
    String descriptionComputed = '';
    String animalNameComputed = '';
    if (animalName.contains('#')) {
      animalNameComputed = animalName.substring(1, animalName.length);
    } else {
      animalNameComputed = "#$animalName";
    }
    // log("$animalName");
    // log("$animalNameComputed");

    descriptionComputed = "$description $animalNameComputed";

    await PostServices()
        .createPost(_selectedClass, urlDownload, title, descriptionComputed);

    close();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () async {
                  await createPost(context);
                },
                child: isLoading
                    ? SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                        ),
                      )
                    : Text('POST'),
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
                  margin: EdgeInsets.only(top: 12),
                  padding: EdgeInsets.all(8),
                  child: uploadFile != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.file(
                            uploadFile!,
                            height: 200,
                            fit: BoxFit.contain,
                          ),
                        )
                      : EmptyImage(),
                )
              : Container(margin: EdgeInsets.symmetric(vertical: 10)),
          PostForm(
              postFormKey: _postFormKey,
              controllerTitle: _controllerTitle,
              controllerAnimalName: _controllerAnimalName,
              controllerDescription: _controllerDescription),
          Container(
            child: Column(
              children: [
                new AnimalsClassSelection(
                    selectedClass: _selectedClass, callback: changingClass),
                mediaAction(action: pickImage)
              ],
            ),
          )
        ],
      ),
    );
  }
}
