import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_house/models/user.dart';
import 'package:pet_house/screens/profile.dart';
import 'package:pet_house/services/authentication_services.dart';
import 'package:pet_house/services/user_services.dart';

import 'package:pet_house/utils/utils.dart';
import 'package:pet_house/widget/common/ImageWidget.dart';

import 'package:bot_toast/bot_toast.dart';
import 'package:pet_house/widget/common/emptyWidget.dart';

class editProfile extends StatefulWidget {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Function submitEditProfile;
  UserModel user;
  editProfile(
      {Key? key,
      required this.formKey,
      required this.usernameController,
      required this.bioController,
      required this.submitEditProfile,
      required this.user})
      : super(key: key);

  @override
  State<editProfile> createState() => _editProfileState();
}

class _editProfileState extends State<editProfile> {
  String? _validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    } else if (value != null && value.contains('@')) {
      return 'Do not use the @ char.';
    }
  }

  File? image;
  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      final imageTemporary = File(image.path);
      setState(() {
        // print(imageTemporary);
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xfffed269),
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.cancel_outlined),
          onPressed: () {
            // BackButton();
            Navigator.pop(context, true);
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              "Cancel",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
                width: 85.0,
                height: 45,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        primary: const Color(0xff4a4a4a)),
                    onPressed: () async {
                      await widget.submitEditProfile(
                          widget.usernameController.text,
                          widget.bioController.text,
                          image,
                          widget.user);
                      BotToast.showNotification(
                        leading: (cancel) => SizedBox.fromSize(
                            size: const Size(40, 40),
                            child: IconButton(
                              icon: const Icon(Icons.check_circle,
                                  color: Colors.green),
                              onPressed: cancel,
                            )),
                        duration: const Duration(seconds: 3),
                        title: (_) =>
                            const Text('Your profile has been updated.'),
                      );
                      Navigator.pop(context, true
                          // {
                          //   'username': widget.usernameController.text,
                          //   'bio': widget.bioController.text
                          // },
                          );
                    },
                    child: const Text(
                      'SAVE',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
      body: Form(
        key: widget.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                image != null
                    ? Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ImageWidget(
                            path: image!,
                            onClicked: () async {
                              pickImage(ImageSource.gallery);
                            }),
                      )
                    : Container(
                        margin: const EdgeInsets.only(top: 16),
                        child: ImageWidget(
                            path: widget.user.urlPictureProfile,
                            onClicked: () async {
                              pickImage(ImageSource.gallery);
                            }),
                      ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  margin: const EdgeInsets.only(top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: const Text(
                          "Email  ",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 5,
                        child: Text(widget.user.email,
                            style: const TextStyle(fontSize: 16)),
                        // child: TextFormField(
                        //   keyboardType: TextInputType.emailAddress,
                        //   decoration: InputDecoration(
                        //       contentPadding: const EdgeInsets.symmetric(
                        //           vertical: 16, horizontal: 10),
                        //       border: OutlineInputBorder(
                        //           borderSide: BorderSide(
                        //         color: Colors.black,
                        //       )),
                        //       hintText: 'email'),
                        //   onSaved: (String? value) {},
                        //   validator: (String? value) {
                        //     return (value != null && value.contains('@'))
                        //         ? 'Do not use the @ char.'
                        //         : null;
                        //   },
                        // ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: const Text(
                            "Username  ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                              controller: widget.usernameController,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 10),
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                    color: Colors.black,
                                  )),
                                  hintText: 'write your username'),
                              onSaved: (String? value) {},
                              validator: _validateUsername),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Expanded(
                          flex: 1,
                          child: const Text(
                            "Bio  ",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 5,
                          child: TextFormField(
                            controller: widget.bioController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 40, horizontal: 10),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                  color: Colors.black,
                                )),
                                hintText: 'Write your desciption...'),
                            onSaved: (String? value) {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
