import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/posts/newPost.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/common/gradientButtonWidget.dart';
import 'package:pet_house/widget/post/postWidget.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
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
          child: StreamBuilder<List<Post>>(
            stream: getPosts(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong! ${snapshot.error}');
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return Center(
                    heightFactor: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          child: EmptyImage(),
                          margin: EdgeInsets.only(top: 8, bottom: 8),
                        ),
                        Text('Oops!',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.colors.secondaryFontColor)),
                        Text('no post found',
                            style: TextStyle(
                                color: AppTheme.colors.secondaryFontColor)),
                        gradientButton(
                          text: 'New post',
                        )
                      ],
                    ),
                  );
                }
                final posts = snapshot.data!;
                return buildPostsGridView(posts);
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
