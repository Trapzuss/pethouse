import 'package:flutter/material.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';
import 'package:pet_house/widget/discovery/cardBottom.dart';
import 'package:pet_house/widget/post/buildPostsGridView.dart';

class DiscoveryScreen extends StatefulWidget {
  final String? searchValue;
  DiscoveryScreen({Key? key, required this.searchValue}) : super(key: key);

  @override
  State<DiscoveryScreen> createState() => _DiscoveryScreenState();
}

class _DiscoveryScreenState extends State<DiscoveryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        widget.searchValue!.isEmpty
            ? Container()
            : Center(
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      'Result of "${widget.searchValue}"',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ))),
        widget.searchValue!.isEmpty
            ? Container()
            : Expanded(
                child: StreamBuilder(
                    stream:
                        PostServices().getPostsBySearching(widget.searchValue!),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return EmptyPostsTypeError(
                            error: snapshot.error.toString());
                      } else if (snapshot.hasData) {
                        final List<PostModel> posts =
                            snapshot.data as List<PostModel>;
                        if (posts.isEmpty) {
                          return EmptyPostsTypeEmpty();
                        }
                        return Container(
                          padding: EdgeInsets.all(4),
                          margin: EdgeInsets.only(top: 8),
                          child: PostsGridView(posts: posts),
                        );
                      }
                      print(snapshot.data);
                      return Center(child: CircularProgressIndicator());
                    }),
              ),
        widget.searchValue!.isEmpty
            ? Expanded(child: card_Bottom())
            : Container(),
      ],
    );
  }
}
