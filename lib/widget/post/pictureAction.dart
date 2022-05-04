import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:image_picker/image_picker.dart';

class pictureAction extends StatefulWidget {
  final action;

  const pictureAction({Key? key, this.action}) : super(key: key);

  @override
  State<pictureAction> createState() => _pictureActionState();
}

class _pictureActionState extends State<pictureAction> {
  File? image;

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
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
                    onTap: () => pickImage(ImageSource.gallery)),
                InkWell(
                  child: Icon(
                    Icons.camera_alt_sharp,
                    color: AppTheme.colors.primaryFontColor,
                  ),
                  onTap: () => pickImage(ImageSource.camera),
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
