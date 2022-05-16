import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/models/collection.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/services/collection_services.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';
import 'package:pet_house/widget/post/postWidget.dart';

class collectionScreen extends StatelessWidget {
  final List<dynamic> postsId;
  collectionScreen({Key? key, required this.postsId}) : super(key: key);
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
          child: FutureBuilder<List<PostModel?>>(
        future: CollectionServices().getPostsInCollection(postsId),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return EmptyPostsTypeError(error: snapshot.error.toString());
          } else if (snapshot.hasData) {
            final posts = snapshot.data;
            // log('$posts');
            if (posts!.isEmpty) {
              return EmptyPostsTypeEmpty();
            }

            return Container(
                margin: EdgeInsets.all(8),
                child: MasonryGridView.count(
                  crossAxisCount: 2,
                  itemCount: posts.length,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  // shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: postWidget(
                          path: posts[index]!.imageUrl,
                          postId: posts[index]!.postId),
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return PostScreen(id: posts[index]!.postId);
                        }));
                        // print('go to post in collections');
                      },
                    );
                  },
                ));
          } else {
            return Center(
                child: CircularProgressIndicator(
              strokeWidth: 2,
            ));
          }
        },
      )),
    );
  }
}
