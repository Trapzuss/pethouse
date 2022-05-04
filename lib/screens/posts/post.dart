import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  Post({Key? key}) : super(key: key);

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: SafeArea(
          child: Container(
              child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  child: Chip(
                    label: Text('Mammals'),
                    avatar: CircleAvatar(child: Icon(Icons.pets)),
                  ),
                ),
                InkWell(
                  child: Icon(Icons.bookmark_border_outlined),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
              child: Image.network(
                'https://www.familyeducation.com/sites/default/files/fe_slideshow/2008_03/Chipmunk_H.jpg',
                fit: BoxFit.contain,
              ),
            ),
            alignment: Alignment.center,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 4),
                        child: Text('Username'))
                  ],
                ),
                Column(
                  children: [Icon(Icons.pets_outlined), Text('Like')],
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8),
            child: Text(
              'Nong narak mak i taw meow.',
              textAlign: TextAlign.left,
            ),
          )
        ],
      ))),
    );
  }
}
