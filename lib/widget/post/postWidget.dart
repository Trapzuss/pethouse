import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pet_house/widget/collection/collectionModal.dart';
import 'package:cached_network_image/cached_network_image.dart';

class postWidget extends StatefulWidget {
  final String? path;
  final String? postId;
  const postWidget({Key? key, required this.path, required this.postId})
      : super(key: key);

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
                child: CachedNetworkImage(
                  imageUrl: widget.path!,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) =>
                      Center(child: Icon(Icons.error)),
                ),

                // ClipRRect(
                //   borderRadius: BorderRadius.circular(8.0),
                //   // https://miro.medium.com/max/1360/1*oggxLUdueZBH5S8XN9kccg.gif

                //   child: Image.network(
                //     widget.path!,
                //     fit: BoxFit.fill,
                //   ),
                // ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    child: InkWell(
                      child: Icon(
                        Icons.bookmark_add,
                        color: Colors.white,
                      ),
                      onTap: () =>
                          {showCollectionModal(context, widget.postId!)},
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
}
