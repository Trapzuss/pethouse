import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/post/animalClassSelection.dart';
import 'package:pet_house/widget/post/pictureAction.dart';
import 'package:pet_house/widget/post/postForm.dart';
import 'package:uuid/uuid.dart';

class updatePostScreen extends StatefulWidget {
  const updatePostScreen({Key? key}) : super(key: key);

  @override
  State<updatePostScreen> createState() => _updatePostScreenState();
}

class _updatePostScreenState extends State<updatePostScreen> {
  var uuid = Uuid();
  File? uploadimage;
  void pickImage(newImage) {
    setState(() {
      this.uploadimage = File(newImage.path);
    });
  }

  final _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();

  Future updatePost() async {
    // TODO send id of post by prop
    // TODO modeling the textformfield with data
    final docPost = FirebaseFirestore.instance
        .collection('posts')
        .doc('Fsh4Trd3GCoYutWqYy10');

    docPost.update({'title': 'ChangedName'});
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
                  await updatePost();
                  Navigator.pop(context);
                },
                child: Text('Save'),
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
