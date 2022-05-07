import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/widget/post/postWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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

  Stream<List<Post>> getPosts() => FirebaseFirestore.instance
      .collection('posts')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => Post.fromJson(doc.data())).toList());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.all(4),
          child:
              // MasonryGridView.count(
              //   crossAxisCount: 2,
              //   itemCount: img.length,
              //   mainAxisSpacing: 12,
              //   crossAxisSpacing: 12,
              //   // shrinkWrap: true,
              //   itemBuilder: (context, index) {
              //     return InkWell(
              //       child: Container(
              //           decoration: BoxDecoration(
              //             borderRadius: BorderRadius.circular(8.0),
              //           ),
              //           child: postWidget(path: img[index])),
              //       onTap: () {
              //         Navigator.push(context, MaterialPageRoute(builder: (context) {
              //           return PostScreen();
              //         }));
              //       },
              //     );
              //   },
              // )
              StreamBuilder<List<Post>>(
            stream: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                final posts = snapshot.data!;
                return buildPostsGridView(posts);
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }

  Widget buildPostsGridView(List<Post> posts) => MasonryGridView.count(
        crossAxisCount: 2,
        itemCount: posts.length,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        // shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: postWidget(path: posts[index].imageUrl)),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return PostScreen(
                  id: posts[index].id,
                );
              }));
            },
          );
        },
      );
}
