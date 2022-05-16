import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:pet_house/utils/utils.dart';

class ImageWidget extends StatelessWidget {
  final path;
  final VoidCallback onClicked;

  const ImageWidget({Key? key, required this.path, required this.onClicked})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        buildImage(),
        Positioned(
          child: buildEditIcon(AppTheme.colors.primary),
          bottom: 0,
          right: 4,
        )
      ],
    );
  }

  Widget buildImage() {
    // print(path);
    // print(path.runtimeType);
    // print(path.runtimeType == String);

    if (path.runtimeType == String) {
      final image = NetworkImage(path);
      // return ClipOval(
      //   child: Material(
      //     color: Colors.transparent,
      //     child: Ink.image(
      //       image: image,
      //       fit: BoxFit.cover,
      //       width: 128,
      //       height: 128,
      //       child: InkWell(onTap: onClicked),
      //     ),
      //   ),
      // );
      return GestureDetector(
          onTap: () {
            onClicked();
          },
          child: CircleAvatar(
            radius: 64,
            backgroundColor: AppTheme.colors.primaryFontColor,
            foregroundColor: Colors.white,
            child: Icon(
              Icons.person,
              size: 96,
            ),
          ));
    } else {
      return ClipOval(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            child: Image.file(
              path!,
              height: 128,
              width: 128,
              fit: BoxFit.cover,
            ),
            onTap: onClicked,
          ),
        ),
      );
    }
  }

  Widget buildEditIcon(Color color) => CircleAvatar(
        backgroundColor: Colors.white,
        child: CircleAvatar(
            radius: 18,
            backgroundColor: AppTheme.colors.primaryFontColor,
            child: Icon(
              Icons.edit,
              size: 20,
              color: Colors.white,
            )),
      );

  Future<ImageSource?> showImageSource(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup<ImageSource>(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.camera),
                      child: Text('Camera')),
                  CupertinoActionSheetAction(
                      onPressed: () =>
                          Navigator.of(context).pop(ImageSource.gallery),
                      child: Text('Gallery'))
                ],
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.camera_alt),
                    title: Text('Camera'),
                    onTap: () => Navigator.of(context).pop(ImageSource.camera),
                  ),
                  ListTile(
                    leading: Icon(Icons.image),
                    title: Text('Gallery'),
                    onTap: () => Navigator.of(context).pop(ImageSource.gallery),
                  )
                ],
              ));
    }
  }
}
