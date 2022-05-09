import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/api/firebase_api.dart';
import 'package:pet_house/models/post.dart';
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
  int _selectedClass = -1;
  UploadTask? task;
  File? uploadFile;
  void pickImage(newMedia) {
    setState(() {
      this.uploadFile = File(newMedia.path);
      // this.uploadFile = newMedia;
    });
  }

  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  Future changingClass(newClass) async {
    setState(() {
      _selectedClass = newClass;
    });
  }

  Future createPost() async {
    var close = BotToast.showLoading();
    print(_selectedClass);
    // #upload file to storage
    if (uploadFile == null) return;
    final fileName = '${basename(uploadFile!.path)}${DateTime.now()}';
    final destination = "files/$fileName";
    task = FirebaseApi.uploadFile(destination, uploadFile!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    print('Dowload-Link: $urlDownload');

    // #create document on firestore
    final title = _controllerTitle.text;
    final description = _controllerDescription.text;
    final docPost = FirebaseFirestore.instance.collection('posts').doc();

    final post = Post(
        id: docPost.id,
        imageUrl: urlDownload,
        title: title,
        description: description,
        animalClass: Post.getAnimalClass(_selectedClass),
        createdAt: DateTime.now());

    final postJson = post.toJson();

    await docPost.set(postJson);

    // print('post successfully');
    close();
    BotToast.showNotification(
      leading: (cancel) => SizedBox.fromSize(
          size: const Size(40, 40),
          child: IconButton(
            icon: Icon(Icons.check_circle, color: Colors.green),
            onPressed: cancel,
          )),
      duration: Duration(seconds: 3),
      title: (_) => Text('Done! check you post'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () async {
                  await createPost();
                  Navigator.pop(context);
                },
                child: Text('POST'),
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
          Container(
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
          ),
          PostForm(
              controllerTitle: _controllerTitle,
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

class EmptyImage extends StatelessWidget {
  const EmptyImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.network(
        AppTheme.src.empty,
        alignment: Alignment.center,
        height: 200,
      ),
    );
  }
}
