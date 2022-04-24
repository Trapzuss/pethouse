import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/widget/post/postWidget.dart';

class Feed extends StatefulWidget {
  const Feed({Key? key}) : super(key: key);

  @override
  State<Feed> createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  final List<String> entries = <String>['A', 'B', 'C'];
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            child: Center(
              child: Post(),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => Divider(),
      ),
    );
  }
}
