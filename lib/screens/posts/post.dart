import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/screens/posts/updatePost.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/services/user_services.dart';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/collection/collectionModal.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';
import 'package:like_button/like_button.dart';

class PostScreen extends StatefulWidget {
  final String id;
  PostScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState(id: this.id);
}

class _PostScreenState extends State<PostScreen> {
  String? id;
  bool? like = false;
  Future? _getPostWithUser;
  _PostScreenState({this.id, this.like});

  Future getPostWithUser() async {
    final future1 = await PostServices().getPostById(id);
    final future2 = await UserServices().getUserByUid(future1!.ownerId);
    final postWithUser = {...future2.toJson(), ...future1.toJson()};
    // print(PostWithUser);
    return postWithUser;
  }

  Future<bool> onFavoriteButtonTap(bool isLiked) async {
    String action = isLiked == false ? 'add' : 'remove';
    await PostServices()
        .onChangeFavorites(action, id!, AuthenticationService().getUid);

    return !isLiked;
  }

  @override
  void initState() {
    _getPostWithUser = getPostWithUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Post'),
          leading: BackButton(
            onPressed: (() {
              Navigator.pop(context, true);
            }),
          )),
      body: FutureBuilder(
        future: _getPostWithUser,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final post = snapshot.data;
            return post == null
                ? Center(child: EmptyPostsTypeSomethingWrong())
                : postFull(post);
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget postFull(dynamic post) {
    List favoritesList = post['favorites'];
    bool isLikedByUser = favoritesList
        .contains(AuthenticationService().getUid.toString().trim());
    bool isOwner =
        post['ownerId'] == AuthenticationService().getUid.toString().trim();
    return SafeArea(
        child: ListView(
      shrinkWrap: true,
      scrollDirection: Axis.vertical,
      children: [
        Container(
          padding: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                child: Transform(
                  transform: new Matrix4.identity()..scale(1.1),
                  child: Chip(
                    backgroundColor: AppTheme.colors.primary,
                    label: Text(post['animalClass']),
                    avatar: CircleAvatar(
                      child: Icon(Icons.pets),
                      backgroundColor: AppTheme.colors.primaryFontColor,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      child: Icon(Icons.bookmark_add_outlined),
                      onTap: () {
                        showCollectionModal(context, post['postId']);
                      },
                    ),
                  ),
                  isOwner
                      ? Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: InkWell(
                            child: Icon(Icons.edit_note_outlined),
                            onTap: () async {
                              bool? res = await Navigator.push(context,
                                  MaterialPageRoute(builder: (_) {
                                return updatePostScreen(post: post);
                              }));
                              if (res != null) {
                                setState(() {
                                  _getPostWithUser = getPostWithUser();
                                });
                              }
                              // print(res);
                            },
                          ),
                        )
                      : Container()
                ],
              )
            ],
          ),
        ),
        CachedNetworkImage(
          fit: BoxFit.contain,
          imageUrl: post['imageUrl'],
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: CircularProgressIndicator(value: downloadProgress.progress),
          ),
          errorWidget: (context, url, error) =>
              Center(child: Icon(Icons.error)),
        ),
        // Image.network(
        //   post['imageUrl'],
        //   fit: BoxFit.contain,
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    foregroundColor: Colors.white,
                    backgroundColor: AppTheme.colors.primaryFontColor,
                    child: post['urlPictureProfile'] != ''
                        ? ClipOval(
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                child: Image.network(
                                  post['urlPictureProfile'],
                                  fit: BoxFit.cover,
                                  width: 128,
                                  height: 128,
                                ),
                              ),
                            ),
                          )
                        // ClipRRect(
                        //     child: post['urlPictureProfile'],
                        //   )
                        : Icon(Icons.person),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        post['username'],
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ))
                ],
              ),
              Column(
                children: [
                  LikeButton(
                    isLiked: isLikedByUser,
                    onTap: onFavoriteButtonTap,
                    likeCount: favoritesList.length,
                  )
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
                post['title'],
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              Text(
                post['description'],
                textAlign: TextAlign.center,
              )
            ],
          ),
        )
      ],
    ));
  }
}
