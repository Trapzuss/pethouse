import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class mediaAction extends StatefulWidget {
  final action;

  const mediaAction({Key? key, this.action}) : super(key: key);

  @override
  State<mediaAction> createState() => _mediaActionState();
}

class _mediaActionState extends State<mediaAction> {
  File? mediaFile;

  Future selectFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
          allowMultiple: false,
          type: FileType.custom,
          allowedExtensions: ['jpg', 'png', 'jpeg', 'mp4', 'avi', 'mov']);
      if (result == null) return;
      final path = result.files.single.path!;

      setState(() {
        mediaFile = File(path.toString());
      });

      // print(path);
      widget.action(mediaFile);
    } on PlatformException catch (e) {
      print('Failed to pick files: $e');
    }
  }

  Future pickMediaFile(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);

      print(imageTemporary);
      setState(() {
        mediaFile = imageTemporary;
      });

      // print(image);
      widget.action(image);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                    child: Icon(
                      Icons.photo_size_select_actual_rounded,
                      color: AppTheme.colors.primaryFontColor,
                    ),
                    onTap: () => selectFile()),

                // onTap: () => pickMediaFile(ImageSource.gallery)),
                InkWell(
                  child: Icon(
                    Icons.camera_alt_sharp,
                    color: AppTheme.colors.primaryFontColor,
                  ),
                  onTap: () => pickMediaFile(ImageSource.camera),
                )
              ],
            ),
          ],
        ));
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
