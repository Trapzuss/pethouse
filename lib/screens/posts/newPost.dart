import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/post/animalClassSelection.dart';
import 'package:pet_house/widget/post/pictureAction.dart';
import 'package:pet_house/widget/post/postForm.dart';
import 'package:uuid/uuid.dart';

class newPost extends StatefulWidget {
  const newPost({Key? key}) : super(key: key);

  @override
  State<newPost> createState() => _newPostState();
}

class _newPostState extends State<newPost> {
  var uuid = Uuid();
  File? uploadimage;
  void pickImage(newImage) {
    setState(() {
      this.uploadimage = File(newImage.path);
    });
  }

  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  Future createPost() async {
    final title = _controllerTitle.text;
    final description = _controllerDescription.text;
    final docPost = FirebaseFirestore.instance.collection('posts').doc();

    // TODO upload image -> imageUrl
    final post = Post(
        id: docPost.id,
        imageUrl:
            'https://ae01.alicdn.com/kf/H35ab780c7bd04d81a9dae76bb729b9813/Vintage-Body-Deer-Cat-Dog-Portrait.jpg_640x640.jpg',
        title: title,
        description: description,
        createdAt: DateTime.now());
    final postJson = post.toJson();

    await docPost.set(postJson);
    print('post successfully');
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
            child: uploadimage != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.file(
                      uploadimage!,
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
                AnimalsClassSelection(),
                pictureAction(action: pickImage)
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
