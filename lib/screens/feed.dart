import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/posts/newPost.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/common/gradientButtonWidget.dart';
import 'package:pet_house/widget/post/buildPostsGridView.dart';
import 'package:pet_house/widget/post/postWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../widget/common/emptyWidget.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          margin: EdgeInsets.only(top: 8),
          padding: EdgeInsets.all(4),
          child: StreamBuilder<List<PostModel>>(
            stream: PostServices().getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return EmptyPostsTypeError(error: snapshot.error.toString());
              } else if (snapshot.hasData) {
                // print(snapshot.data);
                if (snapshot.data!.isEmpty) {
                  return EmptyPostsTypeEmpty();
                }
                final posts = snapshot.data!;
                return PostsGridView(
                  posts: posts,
                );
              } else {
                return Center(
                    child: SpinKitDancingSquare(
                  color: AppTheme.colors.primary,
                ));
              }
            },
          )),
    );
  }

  // Widget buildPostsGridView(List<PostModel> posts) => MasonryGridView.count(
  //       crossAxisCount: 2,
  //       itemCount: posts.length,
  //       mainAxisSpacing: 12,
  //       crossAxisSpacing: 12,
  //       // shrinkWrap: true,
  //       itemBuilder: (context, index) {
  //         return InkWell(
  //           child: Container(
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(8.0),
  //               ),
  //               child: postWidget(
  //                   path: posts[index].imageUrl, postId: posts[index].postId)),
  //           onTap: () {
  //             Navigator.push(context, MaterialPageRoute(builder: (context) {
  //               return PostScreen(
  //                 id: posts[index].postId,
  //               );
  //             }));
  //           },
  //         );
  //       },
  //     );
}
