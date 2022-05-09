import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/widget/post/postWidget.dart';

class collectionScreen extends StatefulWidget {
  const collectionScreen({Key? key}) : super(key: key);

  @override
  State<collectionScreen> createState() => _collectionScreenState();
}

class _collectionScreenState extends State<collectionScreen> {
  List img = [
    'https://www.familyeducation.com/sites/default/files/fe_slideshow/2008_03/Chipmunk_H.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/PotbellyPig_H.jpg',
    'https://www.familyeducation.com/sites/default/files/collection-item/Chinchilla_H.jpg',
    'https://media1.popsugar-assets.com/files/thumbor/PZXP_YZYLIecUhZhKVpH0ThoAsM/fit-in/728xorig/filters:format_auto-!!-:strip_icc-!!-/2019/07/18/646/n/1922243/3a21fb761112a072_pet/i/Royal-Pet-Portraits.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Collection'),
      ),
      body: SafeArea(
          child: Container(
              child: MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: img.length,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            // child: Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(8.0),
            //   ),
            //   child: ClipRRect(
            //     borderRadius: BorderRadius.circular(8.0),
            //     child: Image.network(
            //       img[index],
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            child: postWidget(
              path: img[index],
            ),
            onTap: () {
              // TODO getCollections and send id as prop to PostScreen
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return PostScreen();
              // }
              // ));
              print('go to post in collections');
            },
          );
        },
      ))),
    );
  }
}
