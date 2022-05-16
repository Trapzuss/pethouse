import 'package:flutter/material.dart';
import 'package:pet_house/utils/utils.dart';

class PostForm extends StatefulWidget {
  var controllerTitle = TextEditingController();
  var controllerDescription = TextEditingController();
  var postFormKey = GlobalKey<FormState>();

  PostForm(
      {Key? key,
      required this.postFormKey,
      required this.controllerTitle,
      required this.controllerDescription})
      : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  String? _validateTitle(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please input title for your post';
    }
    return null;
  }

  String? _validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Form(
        key: widget.postFormKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
            padding: EdgeInsets.all(8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Picture title',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                            color: AppTheme.colors.primaryFontColor,
                          ),
                          textAlign: TextAlign.left,
                        ),
                        TextFormField(
                            validator: _validateTitle,
                            controller: widget.controllerTitle,
                            minLines: 1,
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            decoration: InputDecoration.collapsed(
                                hintText: 'Add your post name...'))
                      ]),
                ),
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Description',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: AppTheme.colors.primaryFontColor,
                        ),
                        textAlign: TextAlign.left,
                      ),
                      TextFormField(
                          // validator: _validateDescription,
                          controller: widget.controllerDescription,
                          minLines: 6,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                              hintText:
                                  'Tell people what your picture is all about...  '))
                    ])
              ],
            )),
      ),
    );
  }
}
