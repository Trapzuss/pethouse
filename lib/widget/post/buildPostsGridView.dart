import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/widget/post/postWidget.dart';

class PostsGridView extends StatelessWidget {
  List<PostModel> posts;
  PostsGridView({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      shrinkWrap: true,
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
              child: postWidget(
                  path: posts[index].imageUrl, postId: posts[index].postId)),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PostScreen(
                id: posts[index].postId,
              );
            }));
          },
        );
      },
    );
  }
}
