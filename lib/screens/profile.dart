import 'dart:math';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/screens/edit_Profile.dart';
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
    'https://www.familyeducation.com/sites/default/files/collection-item/PotbellyPig_H.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Chinchilla_H.jpg',
    'https://media1.popsugar-assets.com/files/thumbor/PZXP_YZYLIecUhZhKVpH0ThoAsM/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2019/07/18/646/n/1922243/3a21fb761112a072_pet/i/Royal-Pet-Portraits.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Cockatiels_H.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Iguana_H.jpg',
    'https://ae01.alicdn.com/kf/H35ab780c7bd04d81a9dae76bb729b9813/Vintage-Body-Deer-Cat-Dog-Portrait.jpg_640x640.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/InsectSpider_H.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Hedgehog_H.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Ferret_H.jpg'
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
    return NestedScrollView(
      headerSliverBuilder: (context, _) {
        return [
          SliverList(
              delegate: SliverChildListDelegate([profileHeaderWidget(context)]))
        ];
      },
      body: profileBodyWidget(),
    );
  }

  Widget profileHeaderWidget(BuildContext context) {
    return Column(
      children: [
        image != null
            ? Container(
                margin: EdgeInsets.only(top: 16),
                child: ImageWidget(
                    path: image!,
                    onClicked: () async {
                      pickImage(ImageSource.gallery);
                    }),
              )
            : Container(
                margin: EdgeInsets.only(top: 16),
                child: ImageWidget(
                    path: user.imagePath,
                    onClicked: () async {
                      pickImage(ImageSource.gallery);
                    }),
              ),
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
            onPressed: () async {
              Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Edit_Profile();
                          }));
            },
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
      ],
    );
  }

  Widget profileBodyWidget() {
    return Column(
      children: [postTitleWidget(), Expanded(child: userPostsWidget())],
    );
  }

  Widget postTitleWidget() {
    return Container(
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
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
    );
  }

  Widget userPostsWidget() {
    return Container(
      margin: EdgeInsets.only(top: 8),
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
              // TODO get myPost then send id as prop to PostScreen
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return PostScreen();
              // }));
              print('go to own post in profile');
            },
          );
        },
      ),
    );
  }
}
