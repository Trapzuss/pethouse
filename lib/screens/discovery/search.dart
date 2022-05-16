import 'package:flutter/material.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';
import 'package:pet_house/widget/discovery/cardBottom.dart';
import 'package:pet_house/widget/post/buildPostsGridView.dart';

class SearchScreen extends StatefulWidget {
  final String searchValue;
  SearchScreen({Key? key, required this.searchValue}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.searchValue)),
      body: StreamBuilder<List<PostModel>>(
          stream: PostServices().getPostsBySearching(widget.searchValue),
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
