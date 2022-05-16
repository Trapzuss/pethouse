// ignore_for_file: unnecessary_new

import 'dart:developer';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_house/api/firebase_api.dart';
import 'package:pet_house/models/post.dart';
import 'package:pet_house/models/user.dart';
import 'package:pet_house/screens/edit_profile.dart';
import 'package:pet_house/screens/posts/post.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'package:pet_house/services/post_services.dart';
import 'package:pet_house/services/user_services.dart';

import 'dart:io';
import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/common/ImageWidget.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';
import 'package:pet_house/widget/post/postWidget.dart';
import 'package:path/path.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  // final user = UserPreferences.mockUser;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  int amountOfPosts = 0;
  int amountOfFavorites = 0;
  Future? _retrievedUserData;

  Future signOutCustom(context) async {
    // ignore: avoid_single_cascade_in_expression_statements
    AwesomeDialog(
      context: context,
      dialogType: DialogType.WARNING,
      animType: AnimType.BOTTOMSLIDE,
      title: "Oh no! You're leaving...",
      desc: 'Are you sure?',
      btnCancelText: 'Nope',
      btnOkText: 'Log me Out',
      btnOkColor: Colors.red,
      btnCancelColor: Colors.white,
      dialogBackgroundColor: Color.fromARGB(255, 245, 245, 245),
      buttonsTextStyle: TextStyle(color: Colors.black),
      btnCancelOnPress: () {
        return;
      },
      btnOkOnPress: () async {
        await AuthenticationService().signOut();
        BotToast.showNotification(
          crossPage: true,
          leading: (cancel) => SizedBox.fromSize(
              size: const Size(40, 40),
              child: IconButton(
                icon: Icon(Icons.logout, color: Colors.red),
                onPressed: cancel,
              )),
          duration: Duration(seconds: 3),
          title: (_) => Text('Logged out'),
        );
      },
    )..show();
  }

  Future submitEditProfile(
      String username, String bio, File? uploadFile) async {
    UploadTask? task;
    final isValid = formKey.currentState!.validate();
    String urlDownload = '';
    if (!isValid) return;

    if (uploadFile != null) {
      final fileName = '${basename(uploadFile.path)}${DateTime.now()}';
      final destination = "files/$fileName";
      task = FirebaseApi.uploadFile(destination, uploadFile);
      if (task == null) return;
      final snapshot = await task.whenComplete(() {});
      urlDownload = await snapshot.ref.getDownloadURL();
    }

    await UserServices().onSubmitProfile(username, bio, urlDownload);
  }

  Future<UserModel> retrievedUserData() async {
    final UserModel userData = await new UserServices().getCurrentUser();

    usernameController.text = userData.username;
    bioController.text = userData.bio;
    amountOfPosts =
        await PostServices().getAmountOfPostsOfUserByUid(userData.uid);
    amountOfFavorites =
        await PostServices().getAmountOfFavoritesOfUserByUid(userData.uid);
    return userData;
  }

  @override
  void initState() {
    _retrievedUserData = retrievedUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<dynamic>(
      future: _retrievedUserData,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final UserModel userData = snapshot.data!;
          return NestedScrollView(
            headerSliverBuilder: (context, _) {
              return [
                SliverList(
                    delegate: SliverChildListDelegate(
                        [profileHeaderWidget(context, userData)]))
              ];
            },
            body: profileBodyWidget(userData),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget profileHeaderWidget(BuildContext context, UserModel userData) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                child: Icon(
                  Icons.logout,
                  color: Colors.red,
                ),
                onTap: () {
                  signOutCustom(context);
                },
              )
            ],
          ),
        ),
        (userData.urlPictureProfile != null && userData.urlPictureProfile != '')
            ? ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    child: Image.network(
                      userData.urlPictureProfile,
                      fit: BoxFit.cover,
                      width: 128,
                      height: 128,
                    ),
                  ),
                ),
              )
            : ClipOval(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                      child: CircleAvatar(
                    radius: 64,
                    backgroundColor: AppTheme.colors.primaryFontColor,
                    foregroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 96,
                    ),
                  )

                      // Image.network(
                      //   user.urlPictureProfile,
                      //   fit: BoxFit.cover,
                      //   width: 128,
                      //   height: 128,
                      // ),
                      ),
                ),
              ),
        Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              Text(
                userData.username,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                userData.bio,
                style: TextStyle(color: AppTheme.colors.secondaryFontColor),
              )
            ],
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              bool res = await Navigator.push(context,
                  new MaterialPageRoute(builder: (context) {
                return new editProfile(
                    formKey: formKey,
                    usernameController: usernameController,
                    bioController: bioController,
                    submitEditProfile: submitEditProfile,
                    user: userData);
              }));
              // log('$value');
              if (res) {
                setState(() {
                  _retrievedUserData = retrievedUserData();
                });
              }
            },
            child: Text('Edit'),
            style: ElevatedButton.styleFrom(
                primary: AppTheme.colors.primaryFontColor,
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30)))),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildButtonColumn('Posts', amountOfPosts),
            _buildButtonColumn('Likes', amountOfFavorites),
          ],
        ),
      ],
    );
  }

  Widget profileBodyWidget(userData) {
    return Column(
      children: [postTitleWidget(), Expanded(child: userPostsWidget())],
    );
  }

  Widget postTitleWidget() {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.all(4),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: AppTheme.colors.primaryFontColor.withOpacity(0.05),
              spreadRadius: 2,
              blurRadius: 5),
          BoxShadow(
              color: AppTheme.colors.primary.withOpacity(1),
              spreadRadius: 2,
              blurRadius: 0,
              offset: Offset(0, 4))
        ],
        // border: Border(bottom: BorderSide(width: 2)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Text(
          'My post',
          style: TextStyle(
              color: AppTheme.colors.secondaryFontColor, fontSize: 12),
        ),
        Container(
          padding: EdgeInsets.all(4),
          child: Icon(
            Icons.newspaper,
            color: AppTheme.colors.primaryFontColor,
          ),
        ),
      ]),
    );
  }

  Widget userPostsWidget() {
    // return ElevatedButton(
    //     onPressed: () {
    //       PostServices().getUserPosts(AuthenticationService().getUid);
    //     },
    //     child: Text('yes'));
    return StreamBuilder<List<PostModel>>(
      stream: PostServices().getUserPosts(AuthenticationService().getUid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong! ${snapshot.error}');
        } else if (snapshot.hasData) {
          final posts = snapshot.data;
          if (snapshot.data!.isEmpty) {
            return Center(child: EmptyPostsTypeEmpty());
          }
          return Container(
            margin: EdgeInsets.only(top: 8),
            child: MasonryGridView.count(
              crossAxisCount: 2,
              itemCount: posts!.length,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              // shrinkWrap: true,
              itemBuilder: (context, index) {
                return InkWell(
                  child: postWidget(
                      path: posts[index].imageUrl, postId: posts[index].postId),
                  onTap: () async {
                    bool? res = await Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return PostScreen(id: posts[index].postId);
                    }));

                    if (res!) {
                      setState(() {
                        _retrievedUserData = retrievedUserData();
                      });
                    }

                    // print('go to own post in profile');
                  },
                );
              },
            ),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Column _buildButtonColumn(String label, int text) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
                fontSize: 10, color: AppTheme.colors.secondaryFontColor),
          ),
        ),
        Text(
          text.toString(),
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.colors.primaryFontColor),
        ),
      ],
    );
  }
}
