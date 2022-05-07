import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/post/animalClassSelection.dart';
import 'package:pet_house/widget/post/pictureAction.dart';
import 'package:pet_house/widget/post/postForm.dart';

class createPost extends StatefulWidget {
  const createPost({Key? key}) : super(key: key);

  @override
  State<createPost> createState() => _createPostState();
}

class _createPostState extends State<createPost> {
  File? uploadimage;
  void pickImage(newImage) {
    setState(() {
      this.uploadimage = File(newImage.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.all(8),
            child: ElevatedButton(
                onPressed: () async {},
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
          PostForm(),
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
