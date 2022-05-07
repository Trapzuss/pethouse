import 'package:flutter/material.dart';
import 'package:pet_house/utils/utils.dart';

class PostForm extends StatefulWidget {
  var controllerTitle = TextEditingController();
  var controllerDescription = TextEditingController();

  PostForm(
      {Key? key,
      required this.controllerTitle,
      required this.controllerDescription})
      : super(key: key);

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
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
                          controller: widget.controllerTitle,
                          minLines: 2,
                          keyboardType: TextInputType.multiline,
                          maxLines: null,
                          decoration: InputDecoration.collapsed(
                              hintText: 'Add your picture name...'))
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
    );
  }
}
