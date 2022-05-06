import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class postWidget extends StatefulWidget {
  final String? path;
  const postWidget({Key? key, required this.path}) : super(key: key);

  @override
  State<postWidget> createState() => _postWidgetState();
}

class _postWidgetState extends State<postWidget> {
  final List<IconData> tags = [Icons.pets];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.path!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.white,
                      ),
                      onTap: () => {showCollectionModal(context)},
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }

  Future showCollectionModal(BuildContext context) async {
    if (Platform.isIOS) {
      return showCupertinoModalPopup(
          context: context,
          builder: (context) => CupertinoActionSheet(
                actions: [
                  CupertinoActionSheetAction(
                      onPressed: () => print('yes'),
                      child: Text('Add to Collection')),
                ],
              ));
    } else {
      return showModalBottomSheet(
          context: context,
          builder: (context) => Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.bookmark_add),
                    title: Text('Add to Collection'),
                    onTap: () => print('Add successfully'),
                  ),
                ],
              ));
    }
  }
}
