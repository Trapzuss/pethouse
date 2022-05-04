import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/screens/posts/post.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_house/utils/user_preferences.dart';
import 'dart:io';

import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/common/ImageWidget.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

Column _buildButtonColumn(String label, String text) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        margin: const EdgeInsets.only(top: 8),
        child: Text(
          label,
          style: TextStyle(
              fontSize: 10, color: AppTheme.colors.secondaryFontColor),
        ),
      ),
      Text(
        text,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppTheme.colors.primaryFontColor),
      ),
    ],
  );
}

class _ProfileState extends State<Profile> {
  final user = UserPreferences.mockUser;
  List img = [
    'https://www.familyeducation.com/sites/default/files/fe_slideshow/2008_03/Chipmunk_H.jpg',
    'https://ae01.alicdn.com/kf/H35ab780c7bd04d81a9dae76bb729b9813/Vintage-Body-Deer-Cat-Dog-Portrait.jpg_640x640.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/InsectSpider_H.jpg',
  ];
  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        // print(imageTemporary);
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Center(
            child: Column(
          children: [
            image != null
                ? ImageWidget(
                    path: image!,
                    onClicked: () async {
                      pickImage(ImageSource.gallery);
                    })
                : ImageWidget(
                    path: user.imagePath,
                    onClicked: () async {
                      pickImage(ImageSource.gallery);
                    }),
            Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    user.username,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    user.bio,
                    style: TextStyle(color: AppTheme.colors.secondaryFontColor),
                  )
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () async {},
                child: Text('Edit'),
                style: ElevatedButton.styleFrom(
                    primary: AppTheme.colors.primaryFontColor,
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30)))),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildButtonColumn('Post', '20'),
                _buildButtonColumn('Likes', '50'),
              ],
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.all(4),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: AppTheme.colors.primaryFontColor.withOpacity(0.05),
                      spreadRadius: 2,
                      blurRadius: 5),
                  BoxShadow(
                      color: AppTheme.colors.primary.withOpacity(1),
                      spreadRadius: 2,
                      blurRadius: 0,
                      offset: Offset(0, 4))
                ],
                // border: Border(bottom: BorderSide(width: 2)),
                borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
              ),
              child: Column(mainAxisSize: MainAxisSize.max, children: [
                Text(
                  'My post',
                  style: TextStyle(
                      color: AppTheme.colors.secondaryFontColor, fontSize: 12),
                ),
                Container(
                  padding: EdgeInsets.all(4),
                  child: Icon(
                    Icons.newspaper,
                    color: AppTheme.colors.primaryFontColor,
                  ),
                ),
              ]),
            ),
            UserPicture()
          ],
        )),
      ),
    );
  }

  Widget UserPicture() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.only(top: 12),
      height: 180,
      child: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: img.length,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  img[index],
                  fit: BoxFit.fill,
                ),
              ),
            ),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Post();
              }));
            },
          );
        },
      ),
    ));
  }
}
