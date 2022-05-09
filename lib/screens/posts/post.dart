import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/utils/utils.dart';

class PostScreen extends StatefulWidget {
  final String id;
  PostScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState(id: this.id);
}

class _PostScreenState extends State<PostScreen> {
  String? id;
  bool? like = false;
  _PostScreenState({this.id, this.like});

  Future<Post?> getPostById(id) async {
    final docPost = FirebaseFirestore.instance.collection('posts').doc(id);
    final snapshot = await docPost.get();

    if (snapshot.exists) {
      return Post.fromJson(snapshot.data()!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post'),
      ),
      body: FutureBuilder<Post?>(
        future: getPostById(id),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final post = snapshot.data;
            return post == null
                ? Center(child: Text('No Post'))
                : postFull(post);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget postFull(Post post) {
    return SafeArea(
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
                  backgroundColor: AppTheme.colors.primary,
                  label: Text(post.animalClass),
                  avatar: CircleAvatar(
                    child: Icon(Icons.pets),
                    backgroundColor: AppTheme.colors.primaryFontColor,
                    foregroundColor: Colors.white,
                  ),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Image.network(
              post.imageUrl,
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
                      child: Text(
                        'Username',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
              Column(
                children: [
                  InkWell(
                    radius: 8,
                    child: Icon(
                      Icons.pets,
                    ),
                    // onTap: () {
                    //   setState(() {
                    //     like = !like!;
                    //   });
                    // },
                  ),
                  // like!
                  //     ? InkWell(
                  //         radius: 8,
                  //         child: Icon(
                  //           Icons.pets,
                  //         ),
                  //         onTap: () {
                  //           setState(() {
                  //             like = !like!;
                  //           });
                  //         },
                  //       )
                  //     : InkWell(
                  //         radius: 8,
                  //         child: Image.asset('assets/images/pawprint2.png'),
                  //         onTap: () {
                  //           setState(() {
                  //             like = !like!;
                  //           });
                  //         },
                  //       ),
                  Text('Like')
                ],
              )
            ],
          ),
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                post.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                post.description,
                textAlign: TextAlign.center,
              )
            ],
          ),
        )
      ],
    )));
  }
}
