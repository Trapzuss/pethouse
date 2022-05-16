import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';
import 'package:pet_house/widget/discovery/cardBottom.dart';
import 'package:pet_house/widget/post/buildPostsGridView.dart';
import 'package:pet_house/widget/post/postWidget.dart';
import 'dart:math';

class CategoryScreen extends StatelessWidget {
  final String animalClass;
  const CategoryScreen({Key? key, required this.animalClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(animalClass)),
      body: StreamBuilder<List<PostModel>>(
          stream: PostServices().getPostsByAnimalClass(animalClass),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return EmptyPostsTypeError(error: snapshot.error.toString());
            } else if (snapshot.hasData) {
              final List<PostModel> posts = snapshot.data as List<PostModel>;
              if (posts.isEmpty) {
                return EmptyPostsTypeEmpty();
              }
              return Container(
                  padding: EdgeInsets.all(4),
                  margin: EdgeInsets.only(top: 8),
                  child: PostsGridView(posts: posts));
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
